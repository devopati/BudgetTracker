//
//  ReportsView.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI
import Charts

 // a Bar chart of spending in a  category and budget usage.
struct ReportsView: View {
    @Environment(BudgetViewModel.self) private var viewModel

    private var usedShare: Double {
        guard viewModel.monthlyBudget > 0 else { return 0 }
        return min(viewModel.totalSpent / viewModel.monthlyBudget, 1)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Spending by category")
                            .font(.app(16, relativeTo: .headline))
                            .fontWeight(.semibold)

                        Chart(ExpenseCategory.allCases) { category in
                            BarMark(
                                x: .value("Category", category.shortName),
                                y: .value("Spent", viewModel.total(for: category))
                            )
                            .foregroundStyle(category.color)
                            .cornerRadius(6)
                        }
                        .frame(height: 240)
                    }
                    .cardStyle()

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Budget used")
                            .font(.app(16, relativeTo: .headline))
                            .fontWeight(.semibold)
                        ProgressView(value: usedShare)
                            .tint(usedShare < 0.8 ? .appPrimary : .orange)
                        HStack {
                            Text("Spent \(viewModel.totalSpent.ksh)")
                            Spacer()
                            Text("of \(viewModel.monthlyBudget.ksh)")
                        }
                        .font(.app(13))
                        .foregroundStyle(.secondary)
                    }
                    .cardStyle()
                }
                .padding()
            }
            .background(Color.appBackground)
            .navigationTitle("Reports")
        }
    }
}

#Preview {
    ReportsView()
        .environment(BudgetViewModel.preview)
}
