//
//  SpendBreakdownView.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

 // the total that is  spend this month
struct SpendBreakdownView: View {
    @Environment(BudgetViewModel.self) private var viewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Spend this Monthly")
                        .font(.app(13))
                        .foregroundStyle(.secondary)
                    Text(viewModel.totalSpent.ksh)
                        .font(.app(18, relativeTo: .headline))
                        .fontWeight(.bold)
                }
                Spacer()
                monthPicker
            }

            stackedBar

            VStack(spacing: 10) {
                ForEach(ExpenseCategory.allCases) { category in
                    HStack {
                        Circle()
                            .fill(category.color)
                            .frame(width: 10, height: 10)
                        Text(category.rawValue)
                            .font(.app(14))
                        Spacer()
                        Text(viewModel.total(for: category).ksh)
                            .font(.app(14))
                    }
                }
            }
        }
        .cardStyle()
    }

    private var monthPicker: some View {
        Menu {
            ForEach(viewModel.availableMonths, id: \.self) { month in
                Button(month.formatted(.dateTime.month(.wide).year())) {
                    withAnimation { viewModel.selectedMonth = month }
                }
            }
        } label: {
            HStack(spacing: 4) {
                Text(viewModel.selectedMonth.monthName)
                Image(systemName: "chevron.down")
                    .font(.caption)
            }
            .font(.app(13))
            .foregroundStyle(.primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .overlay(Capsule().stroke(Color.gray.opacity(0.5)))
        }
    }

    // 1 bar split by how much eah one of the category takes of the total.
    private var stackedBar: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(ExpenseCategory.allCases) { category in
                    let share = viewModel.totalSpent > 0
                        ? viewModel.total(for: category) / viewModel.totalSpent
                        : 0
                    Rectangle()
                        .fill(category.color)
                        .frame(width: geometry.size.width * share)
                }
            }
        }
        .frame(height: 26)
        .background(Color.gray.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .animation(.easeInOut, value: viewModel.totalSpent)
    }
}

#Preview {
    SpendBreakdownView()
        .environment(BudgetViewModel.preview)
        .padding()
}
