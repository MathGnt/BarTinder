# 🍸 BarTinder

<div align="center">
  
  ### *Swipe your way to the perfect cocktail* 🥂
  
  ![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)
  ![SwiftUI](https://img.shields.io/badge/SwiftUI-iOS%2017+-blue.svg)
  ![SwiftData](https://img.shields.io/badge/SwiftData-Enabled-green.svg)
  ![Architecture](https://img.shields.io/badge/Architecture-Clean-purple.svg)

</div>

---

## 🎯 **What is BarTinder?**

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
- **Smart Matching**: AI-powered cocktail suggestions based on your preferences  
- **Recipe Discovery**: Explore cocktails you can make with liked ingredients
- **Custom Creation**: Build your own signature cocktails

### **Creation Tools**
- **Recipe Builder**: Add ingredients with precise measurements
- **Visual Customization**: Upload cocktail photos and select glassware among many other options
- **Personal Library**: Save and organize your creations

---

## **Technical Architecture**

### **Clean Architecture Pattern**
Built with a robust **Clean Architecture** approach, ensuring:
- **Separation of Concerns**: Clear boundaries between UI, business logic, and data
- **Testability**: Isolated components for comprehensive testing
- **Maintainability**: Scalable and readable codebase
- **SOLID Principles**: Following best practices for iOS development

### 🗄 **SwiftData Integration**

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

---

## 🛠 **Tech Stack**

| Technology | Purpose |
|------------|---------|
| **SwiftUI** | Modern, declarative UI framework |
| **SwiftData** | Core Data successor for persistence |
| **Swift 6** | Latest language features & concurrency |
| **MVVM + Clean Architecture** | Scalable architectural pattern |
| **Custom Environment Values** | Dependency injection pattern |

---

## 📱 **Screenshots**

*Coming soon! 📸*

---

## 🚀 **Getting Started**

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

3. Build and run! 🎉

---

## **Architecture Highlights**

### **Data Flow**
```
SwiftUI Views → ViewModels → UseCases → Repository → SwiftDataSource → SwiftData
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

## **Author**

**Mathis Gaignet**
- 🌍 iOS Developer from France
- 🎵 Audio Engineering background
- 🍎 Passionate about SwiftUI & Apple ecosystem

---

## **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  
  ### *Made with ❤️ and 🎸*
  
  **If you like this project, don't forget to give it a ⭐!**

</div>
