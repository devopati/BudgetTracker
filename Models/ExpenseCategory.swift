//
//  ExpenseCategory.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import Foundation

enum ExpenseCategory: String, CaseIterable, Identifiable {
    case food = "Food & Beverage"
    case transport = "Transport & Fuel"
    case clothing = "Clothing"
    case fees = "Transaction Fees"

    var id: String { rawValue }

    //Short label for chart xes,
    var shortName: String {
        switch self {
        case .food: return "Food"
        case .transport: return "Transport"
        case .clothing: return "Clothing"
        case .fees: return "Fees"
        }
    }
}



