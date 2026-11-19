//
//  Theme.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }

    static let appPrimary = Color(hex: 0x80BA27)
    static let appSecondary = Color(hex: 0x00513A)

    // Light: F1F0F5, Dark: 010100
    static let appBackground = Color(UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 0x01 / 255, green: 0x01 / 255, blue: 0x00 / 255, alpha: 1)
            : UIColor(red: 0xF1 / 255, green: 0xF0 / 255, blue: 0xF5 / 255, alpha: 1)
    })

    // for white cards in light mode, dark grey in dark mode.
    static let cardBackground = Color(.secondarySystemGroupedBackground)
}

extension Font {
    static func app(_ size: CGFloat, relativeTo style: Font.TextStyle = .body) -> Font {
        .custom("ProductSans-Regular", size: size, relativeTo: style)
    }
}

extension View {
    // Rounded card used across the app.
    func cardStyle() -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
