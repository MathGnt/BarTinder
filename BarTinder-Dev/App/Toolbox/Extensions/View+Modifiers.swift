import Foundation
import SwiftUI

extension View {
    func cardTitle() -> some View {
        self
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .font(.system(size: 30, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
    }
    
    func cardABV() -> some View {
        self
            .font(.system(size: 25, weight: .regular, design: .rounded))
            .foregroundColor(.white)
    }
    
    func cardLocation() -> some View {
        self
            .font(.system(size: 18, weight: .semibold, design: .rounded))
            .foregroundStyle(.white)
            .padding(.leading, 7)
            .padding(.trailing, 7)
            .background(.thinMaterial)
            .bartinderRounder()
    }
    
    func bartinderRounder(_ radius: CGFloat = BarTinderApp.CornerRadius.main) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: radius))
    }
}
