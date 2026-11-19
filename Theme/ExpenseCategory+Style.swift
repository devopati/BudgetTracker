//
//  ExpenseCategory+Style.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

// colours and icons live in the UI layer, so the model stays free of SwiftUI.
extension ExpenseCategory {
    var color: Color {
        switch self {
        case .food: return Color(hex: 0x1B3A5B)
        case .transport: return .appPrimary
        case .clothing: return Color(hex: 0x6CCFF6)
        case .fees: return Color(hex: 0xF2784B)
        }
    }

    var icon: String {
        switch self {
        case .food: return "fork.knife"
        case .transport: return "car.fill"
        case .clothing: return "tshirt.fill"
        case .fees: return "creditcard.fill"
        }
    }
}
