//
//  TransactionRowView.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

 // a row in the recent transactions and the budgets list
struct TransactionRowView: View {
    let expense: Expense

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: expense.category.icon)
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .background(expense.category.color)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(expense.name)
                    .font(.app(15))
                    .fontWeight(.semibold)
                Text(expense.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.app(12))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(expense.amount.ksh)
                    .font(.app(15))
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
                Text(expense.category.rawValue)
                    .font(.app(12))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(10)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2)))
    }
}
