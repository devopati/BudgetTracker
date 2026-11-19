//
//  BudgetView.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

 // Spennding for each of category and every expense of the selected month and has wipe to delete.
struct BudgetsView: View {
    @Environment(BudgetViewModel.self) private var viewModel

    var body: some View {
        NavigationStack {
            List {
                Section("\(viewModel.selectedMonth.monthName) by category") {
                    ForEach(ExpenseCategory.allCases) { category in
                        HStack {
                            Image(systemName: category.icon)
                                .foregroundStyle(category.color)
                                .frame(width: 24)
                            Text(category.rawValue)
                            Spacer()
                            Text(viewModel.total(for: category).ksh)
                                .fontWeight(.semibold)
                        }
                        .font(.app(15))
                    }
                }

                Section("All transactions") {
                    if viewModel.monthExpenses.isEmpty {
                        Text("No expenses this month.")
                            .foregroundStyle(.secondary)
                    }
                    ForEach(viewModel.monthExpenses) { expense in
                        TransactionRowView(expense: expense)
                            .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: delete)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.appBackground)
            .navigationTitle("Budgets")
        }
    }

    private func delete(at offsets: IndexSet) {
        let toDelete = offsets.map { viewModel.monthExpenses[$0] }
        withAnimation {
            toDelete.forEach(viewModel.delete)
        }
    }
}

#Preview {
    BudgetsView()
        .environment(BudgetViewModel.preview)
}
