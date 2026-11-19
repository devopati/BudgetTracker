//
//  MainTabView.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

enum AppTab: CaseIterable {
    case home, budgets, reports, account

    var title: String {
        switch self {
        case .home: return "Home"
        case .budgets: return "Budgets"
        case .reports: return "Reports"
        case .account: return "Account"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .budgets: return "square.grid.2x2"
        case .reports: return "chart.bar.xaxis"
        case .account: return "person"
        }
    }
}

struct MainTabView: View {
    @Environment(BudgetViewModel.self) private var viewModel
    @State private var selectedTab: AppTab = .home
    @State private var showAddExpense = false

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView(onViewAll: {
                        withAnimation(.easeInOut(duration: 0.25)) { selectedTab = .budgets }
                    })
                case .budgets:
                    BudgetsView()
                case .reports:
                    ReportsView()
                case .account:
                    AccountView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .id(selectedTab)         // a transition
            .transition(.opacity)

            BottomBar(selectedTab: $selectedTab) {
                showAddExpense = true
            }
        }
        .background(Color.appBackground)
        .sheet(isPresented: $showAddExpense) {
            AddExpenseView()
                .environment(viewModel)
        }
    }
}

#Preview {
    MainTabView()
        .environment(BudgetViewModel.preview)
}
