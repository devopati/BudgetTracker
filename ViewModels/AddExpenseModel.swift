//
//  AddExpenseModel.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import Foundation
import Observation

 //a form state and validation for the Add Expense screen.
@Observable
final class AddExpenseViewModel {
    var category: ExpenseCategory = .food
    var itemName = ""
    var amountText = ""

    var trimmedName: String {
        itemName.trimmingCharacters(in: .whitespaces)
    }

    var amount: Double? {
        Double(amountText)
    }

    var isValid: Bool {
        !trimmedName.isEmpty && (amount ?? 0) > 0
    }
}
