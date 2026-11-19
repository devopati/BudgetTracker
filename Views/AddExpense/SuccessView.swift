//
//  SuccessView.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

  // confirmation for budget item added
struct SuccessView: View {
    let expense: Expense
    var onDone: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 72))
                .foregroundStyle(Color.appPrimary)
                .padding(.top, 32)

            VStack(spacing: 6) {
                Text("Budget Item Added")
                    .font(.app(20, relativeTo: .title3))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.appSecondary)
                Text("Budget item has been added successfully")
                    .font(.app(14))
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 12) {
                detailRow("Budget Item Name", expense.name)
                detailRow("Category", expense.category.rawValue)
                detailRow("Amount", expense.amount.ksh, valueColor: .appPrimary)
                detailRow("Date", expense.date.formatted(date: .long, time: .omitted))
            }
            .cardStyle()

            Spacer()

            Button(action: onDone) {
                Text("Go back to Home")
                    .font(.app(16))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appSecondary)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding()
    }

    private func detailRow(_ title: String, _ value: String,
                           valueColor: Color = .primary) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .foregroundStyle(valueColor)
        }
        .font(.app(14))
    }
}
