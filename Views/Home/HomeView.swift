//
//  HomeView.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

struct HomeView: View {
    @Environment(BudgetViewModel.self) private var viewModel
    var onViewAll: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                header
                BalanceCardView(remaining: viewModel.remainingBalance)
                SpendBreakdownView()
                recentTransactions
            }
            .padding()
        }
        .background(Color.appBackground)
    }

    private var header: some View {
        HStack(spacing: 12) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 36))
                .foregroundStyle(Color.appSecondary)
            Text("Welcome back, \(viewModel.userName)")
                .font(.app(17, relativeTo: .headline))
                .fontWeight(.semibold)
            Spacer()
            Image(systemName: "bell")
                .font(.system(size: 20))
                .foregroundStyle(Color.appPrimary)
                .padding(8)
                .overlay(Circle().stroke(Color.appPrimary, lineWidth: 1.5))
        }
    }

    private var recentTransactions: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Recent Transactions")
                    .font(.app(16, relativeTo: .headline))
                    .fontWeight(.semibold)
                Spacer()
                Button(action: onViewAll) {
                    Label("View All", systemImage: "arrow.up.right.square")
                        .font(.app(14))
                        .labelStyle(.titleAndIcon)
                }
                .foregroundStyle(Color.appPrimary)
            }

            if viewModel.recentTransactions.isEmpty {
                Text("No transactions yet. Tap + to add your first expense")
                    .font(.app(14))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 32)
            } else {
                ForEach(viewModel.recentTransactions) { expense in
                    TransactionRowView(expense: expense)
                }
            }
        }
        .cardStyle()
    }
}

#Preview {
    HomeView(onViewAll: {})
        .environment(BudgetViewModel.preview)
}
