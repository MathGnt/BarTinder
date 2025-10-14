# 🍸 BarTinder

<div align="center">
  
  ### *Swipe your way to the perfect cocktail* 🥂
  
  ![Swift](https://img.shields.io/badge/Swift-6.2-orange.svg)
  ![SwiftUI](https://img.shields.io/badge/SwiftUI-iOS%2026+-blue.svg)
  ![SwiftData](https://img.shields.io/badge/SwiftData-Enabled-green.svg)
  ![Architecture](https://img.shields.io/badge/Architecture-Clean-purple.svg)

</div>

---

## **What is BarTinder?**

**BarTinder** is the ultimate cocktail discovery app that revolutionizes how you explore and create drinks. Think Tinder, but for cocktail ingredients! 

### **The Magic Flow**

1. **Swipe Ingredients** → Browse ingredient cards with satisfying swipe gestures
2. **Like or Pass** → Express your taste preferences 
3. **Discover Cocktails** → Get personalized recommendations based on your choices
4. **Create Your Own** → Build custom cocktails with unlimited creativity

---

## **Features**

### **Core Experience**
- **Tinder-like Swiping**: Intuitive card-based ingredient selection
- **Recipe Discovery**: Explore cocktails you can make with liked ingredients
- **Custom Creation**: Build your own signature cocktails!

### **Creation Tools**
- **Recipe Builder**: Add ingredients with precise measurements
- **Visual Customization**: Upload cocktail photos and select your cocktails options among glassware, flavor, ABV..
- **Personal Library**: Save and organize your creations

### **AI-Powered Cocktail Generation**
- **Apple Intelligence Integration**: Leverage Foundation Models to generate creative cocktail ideas
- **Guided AI Output**: Use existing app data (ingredients, glassware, techniques) to constrain AI generation
- **One-Word Input**: Simply enter a word (like "Ocean", "Summer", or "Spicy") and let Apple Intelligence create a complete cocktail recipe
- **Structured Generation**: AI respects your app's domain model using `@Generable` and `@Guide` macros

---

## **Technical Architecture**

### **Clean Architecture Pattern**
Built with a robust **Clean Architecture** approach, ensuring:
- **Separation of Concerns**: Clear boundaries between UI, business logic, and data
- **Testability**: Isolated components for comprehensive testing
- **Maintainability**: Scalable and readable codebase
- **SOLID Principles**: Following best practices for iOS development

<div align="center">
<img src="screenshots/cleanarchi.png" width="600" alt="Clean Architecture Diagram">
</div>

### **SwiftData Integration**

The app leverages **SwiftData** with a custom abstraction layer to keep data logic out of views:

```swift
// Custom SwiftData wrapper for clean separation
final class SwiftDataSource {
    let context: ModelContext?
    
    func contextInsert<T: PersistentModel>(_ item: T)
    func contextDelete<T: PersistentModel>(_ item: T)
    func getContextContent<T: PersistentModel>(_ type: T.Type) -> [T]
    // ... more methods
}

// Environment injection for seamless access
extension EnvironmentValues {
    @Entry var swiftData = SwiftDataSource()
}
```

**Benefits:**
- **No Context Pollution**: Views stay focused on presentation
- **Reusable Logic**: Consistent data operations across the app
- **Easy Testing**: Mock-friendly architecture
- **Clean Views**: SwiftUI views remain declarative and simple

### **Hybrid Approach: Best of Both Worlds**
While most data operations flow through Use Cases via dependency injection, 
the Environment pattern provides flexibility for simple, direct operations:

```swift
// For complex business logic: Use Cases handle the flow
cocktailUseCase.createCocktail(with: ingredients)

// For simple UI actions: Direct environment access
@Environment(\.swiftData) private var swiftData

Button("Reset") {
    swiftData.contextDeleteAll(Cocktail.self)
    finishSwiping = false
}
```

**Why this dual approach?:**
- **Efficiency**: Avoid unnecessary pipelines for simple operations
- **Pragmatism**: All of your Swift Data operations stay in the same place!

---

### **Apple Intelligence with Foundation Models**

BarTinder leverages **Apple Intelligence** to generate creative cocktail recipes using a unique approach: **guiding AI with existing app data** to ensure generated cocktails respect the app's domain model.

#### **The Challenge**
Traditional AI generation can produce inconsistent or invalid data. How do you ensure Apple Intelligence generates cocktails that match your app's structure (valid glassware, real ingredients, proper units)?

#### **The Solution: Guided Structured Generation**

Using the `@Generable` and `@Guide` macros from Foundation Models, we constrain AI output to only produce valid cocktails based on **existing app data**:

```swift
import FoundationModels

@Generable
struct CocktailIdea {
    // Free-form text generation
    @Guide(description: "A cool name for the cocktail")
    var name: String

    @Guide(description: "A short description for the cocktail")
    var description: String

    // Constrained to existing app data using .anyOf()
    @Guide(.anyOf(CocktailGlass.allCases.map(\.rawValue)))
    var glass: String

    @Guide(.anyOf(CocktailMixingTechnique.allCases.map(\.rawValue)))
    var mixingTechnique: String

    @Guide(.anyOf(CocktailStyle.allCases.map(\.rawValue)))
    var style: String

    @Guide(.anyOf(CocktailDifficulty.allCases.map(\.rawValue)))
    var difficulty: String

    // Nested structured generation with constraints
    @Guide(description: "The ingredients for the cocktail")
    var ingredients: [IngredientIdea]
}

@Generable
struct IngredientIdea {
    // Only ingredients that exist in the app
    @Guide(.anyOf(CardIngredient.ingredientCards.map(\.name)))
    var name: String

    // Constrained range for realistic amounts
    @Guide(description: "A number that represent the amount", .range(1...20))
    var amount: Int

    // Valid units only (cl, ml, wedge, etc.)
    @Guide(.anyOf(Units.allCases.map(\.rawValue)))
    var unit: String
}
```

#### **How It Works**

**1. User enters a single word** (e.g., "Ocean", "Tropical", "Smoky")

**2. ViewModel initiates streaming generation:**
```swift
@Observable
final class GenerableModel {
    let session: LanguageModelSession
    var cocktailIdea: LanguageModelSession.ResponseStream<CocktailIdea>.Snapshot?

    func generate() async {
        // Check device availability
        guard useCase.executeCheckingAvailability() else {
            notAvailable = true
            return
        }

        let prompt = "Give me an idea for a cocktail that represents the word \(word)"
        let streamingResponse = session.streamResponse(to: prompt, generating: CocktailIdea.self)

        do {
            // Real-time streaming updates
            for try await cocktailIdea in streamingResponse {
                self.cocktailIdea = cocktailIdea
            }
        } catch LanguageModelSession.GenerationError.guardrailViolation {
            // Handle content safety violations
            guardrailViolation = true
        }
    }
}
```

**3. UseCase transforms AI output to domain model:**
```swift
final class GenerableUseCase {
    func executeCreateCocktail(cocktailIdea: Snapshot?) -> Cocktail? {
        guard let name = cocktailIdea?.content.name else { return nil }
        guard let ingredients = cocktailIdea?.content.ingredients else { return nil }
        guard let glass = CocktailGlass(rawValue: cocktailIdea?.content.glass ?? "highball") else { return nil }

        var finalIngredients: [Ingredient] = []
        for ingredient in ingredients {
            let newIngredient = Ingredient(
                name: ingredient.name ?? "",
                measure: String(ingredient.amount ?? 0),
                unit: Units(rawValue: ingredient.unit ?? "cl") ?? .cl
            )
            finalIngredients.append(newIngredient)
        }

        return Cocktail(
            name: name,
            ingredients: finalIngredients,
            style: glass,
            // ... other properties
        )
    }
}
```

#### **Key Features**

**Device Availability Checking**
```swift
switch SystemLanguageModel.default.availability {
case .available:
    return true
case .unavailable(.deviceNotEligible):
    return false
}
```

**Performance Optimization with Prewarming**
```swift
// Prewarm model when user focuses on text field
.onChange(of: focus) { _, newValue in
    if newValue == .word {
        model.prewarm()
    }
}
```

**Guardrail Violation Handling**
```swift
catch LanguageModelSession.GenerationError.guardrailViolation {
    guardrailViolation = true
    // Show appropriate error to user
}
```

**Streaming Responses for Real-Time Feedback**
- Users see cocktail details appear progressively
- Better UX than waiting for complete generation

#### **Why This Approach Works**

**Data Integrity**: AI can only generate cocktails with valid ingredients, glassware, and units that exist in your app

**Domain Consistency**: Generated cocktails seamlessly integrate into the app's existing architecture

**User Trust**: Users get realistic, actionable cocktail recipes, not random AI hallucinations

**Clean Architecture**: Foundation Models integration respects Use Cases → Repository → Domain model pattern

---

## **Tech Stack**

| Technology | Purpose |
|------------|---------|
| **SwiftUI** | Modern, declarative UI framework |
| **SwiftData** | Core Data successor for persistence |
| **Swift 6** | Latest language features & concurrency |
| **Foundation Models** | Apple Intelligence for AI-powered cocktail generation |
| **MVVM + Clean Architecture** | Scalable architectural pattern |
| **Custom Environment Values** | Dependency injection pattern |

---

## **Demo**

<div align="center">

### **📱 Watch the Full App Demo**
[![BarTinder Demo Video](https://img.shields.io/badge/▶️_Watch_Demo-2m44s-red?style=for-the-badge&logo=youtube)](https://github.com/MathGnt/BarTinder/releases/download/1.0/BarTinder.mov)

*Full app walkthrough showing ingredient swiping, cocktail discovery, and creation features*

</div>

---

## **Screenshots**

<div align="center">

### **Ingredient Swiping**
<img src="screenshots/swiping-portrait.png" width="300" alt="Ingredient Swiping Interface">

### **Bar Discovery**
<img src="screenshots/bar-portrait.png" width="300" alt="Bar Discovery Screen">

### **Cocktail Details**
<img src="screenshots/cocktaildetail-portrait.png" width="300" alt="Cocktail Detail View">

### **Your Cocktails**
<img src="screenshots/yourcocktails-portrait.png" width="300" alt="Personal Cocktail Library">

### **Cocktail Creation**
<img src="screenshots/cocktailcreation-portrait.png" width="300" alt="Cocktail Creation Interface">

### **Ingredient Creation**
<img src="screenshots/ingredientscreation-portrait.png" width="300" alt="Ingredient Creation Screen">

</div>

---

## **Getting Started**

### Prerequisites
- iOS 17.0+
- Xcode 15.0+
- Swift 6.0+

### Installation
1. Clone the repository
```bash
git clone https://github.com/mathisgaignet/BarTinder.git
```

2. Open in Xcode
```bash
cd BarTinder
open BarTinder.xcodeproj
```

3. Build and run!

---

## **Architecture Highlights**

### **Data Flow**
```
SwiftUI Views → ViewModels → UseCases → Repository → SwiftDataSource OR DataSource (API)
```

### **Layer Separation**
- **Presentation Layer**: SwiftUI Views + ViewModels
- **Domain Layer**: Business logic + Use cases  
- **Data Layer**: SwiftData + Custom abstraction

### **Dependency Injection**
Using Factory system for clean, testable dependencies:

```swift
 func makeCocktailRepo() -> Servable {
        return CocktailRepo(cocktailDataSource: makeCocktailDataSource(), swiftDataSource: makeSwiftDataSource())
    }
```

---

## **Contributing**

Contributions are welcome! Feel free to:
- Report bugs
- Suggest features  
- Submit pull requests
- Star the project

---

## **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  
  ### *Made with ❤️ and 🎸*
  
  **If you like this project, don't forget to give it a ⭐!**

</div>
