//
//  PreviewData.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import Foundation
import SwiftData

 // In-memory data for Xcode previews only. did't touches the real database.
extension BudgetViewModel {
    private static let previewContainer: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try! ModelContainer(for: Expense.self, configurations: config)
    }()

    static let preview: BudgetViewModel = {
        let viewModel = BudgetViewModel(context: previewContainer.mainContext)
        if viewModel.expenses.isEmpty {
            viewModel.addExpense(name: "all Fees", category: .fees, amount: 500)
            viewModel.addExpense(name: "Train", category: .transport, amount: 6000)
            viewModel.addExpense(name: "mitumba", category: .clothing, amount: 1500)
            viewModel.addExpense(name: "KFC Chicken", category: .food, amount: 2000)
        }
        return viewModel
    }()
}
