
//  Expense.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.


import Foundation
import SwiftData

/// One expese saed in the local database.
@Model
final class Expense {
    var name: String
    var categoryRaw: String      // stored as text so the database stays simple
    var amount: Double
    var date: Date

    var category: ExpenseCategory {
        ExpenseCategory(rawValue: categoryRaw) ?? .food
    }

    init(name: String, category: ExpenseCategory, amount: Double, date: Date = .now) {
        self.name = name
        self.categoryRaw = category.rawValue
        self.amount = amount
        self.date = date
    }
}




