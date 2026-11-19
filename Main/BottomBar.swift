//
//  BottomBar.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

 // bottom navigation
struct BottomBar: View {
    @Binding var selectedTab: AppTab
    var onAdd: () -> Void

    var body: some View {
        HStack(alignment: .bottom) {
            tabButton(.home)
            tabButton(.budgets)
            addButton
            tabButton(.reports)
            tabButton(.account)
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .background(Color.cardBackground.ignoresSafeArea(edges: .bottom))
    }

    private var addButton: some View {
        Button(action: onAdd) {
            Image(systemName: "plus")
                .font(.title2.bold())
                .foregroundStyle(.white)
                .frame(width: 58, height: 58)
                .background(
                    LinearGradient(colors: [.appPrimary, .appSecondary],
                                   startPoint: .top, endPoint: .bottom)
                )
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.2), radius: 4, y: 2)
        }
        .offset(y: -10)
        .frame(maxWidth: .infinity)
        .accessibilityLabel("Add expense")
    }

    private func tabButton(_ tab: AppTab) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.25)) { selectedTab = tab }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 20))
                Text(tab.title)
                    .font(.app(11, relativeTo: .caption2))
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(selectedTab == tab ? Color.appPrimary : .gray)
        }
    }
}
