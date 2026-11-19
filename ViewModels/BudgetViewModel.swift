//
//  BudgetViewModel.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import Foundation
import SwiftData
import Observation

 //here we have budget data to shared by every tab
@MainActor
@Observable
final class BudgetViewModel {
    private enum Keys {
        static let budget = "monthlyBudget"
        static let name = "userName"
    }

    private let context: ModelContext

    private(set) var expenses: [Expense] = []
    var selectedMonth: Date = .now

    var monthlyBudget: Double {
        didSet { UserDefaults.standard.set(monthlyBudget, forKey: Keys.budget) }
    }

    var userName: String {
        didSet { UserDefaults.standard.set(userName, forKey: Keys.name) }
    }

    init(context: ModelContext) {
        self.context = context
        let savedBudget = UserDefaults.standard.double(forKey: Keys.budget)
        self.monthlyBudget = savedBudget > 0 ? savedBudget : 200_000
        self.userName = UserDefaults.standard.string(forKey: Keys.name) ?? "John Doee"
        fetchExpenses()
    }

    // MARK: - Derived data

    //expenses in the month chossen on the Homescreen.
    var monthExpenses: [Expense] {
        expenses.filter {
            Calendar.current.isDate($0.date, equalTo: selectedMonth, toGranularity: .month)
        }
    }

    var totalSpent: Double {
        monthExpenses.reduce(0) { $0 + $1.amount }
    }

    var remainingBalance: Double {
        monthlyBudget - totalSpent
    }

    var recentTransactions: [Expense] {
        Array(monthExpenses.prefix(5))
    }

    func total(for category: ExpenseCategory) -> Double {
        monthExpenses
            .filter { $0.category == category }
            .reduce(0) { $0 + $1.amount }
    }

    // last 12 months, newest first, for the month picker.
    var availableMonths: [Date] {
        (0..<12).compactMap {
            Calendar.current.date(byAdding: .month, value: -$0, to: .now)
        }
    }

    // MARK: - Actions

    func fetchExpenses() {
        let descriptor = FetchDescriptor<Expense>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        expenses = (try? context.fetch(descriptor)) ?? []
    }

    @discardableResult
    func addExpense(name: String, category: ExpenseCategory, amount: Double) -> Expense {
        let expense = Expense(name: name, category: category, amount: amount)
        context.insert(expense)
        try? context.save()
        selectedMonth = .now          // show the month the expense was added to
        fetchExpenses()
        return expense
    }

    func delete(_ expense: Expense) {
        context.delete(expense)
        try? context.save()
        fetchExpenses()
    }
}
