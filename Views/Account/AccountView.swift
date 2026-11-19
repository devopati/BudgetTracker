//
//  AccountView.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

 // edit for display name and saved locally
struct AccountView: View {
    @Environment(BudgetViewModel.self) private var viewModel

    var body: some View {
        @Bindable var viewModel = viewModel

        NavigationStack {
            Form {
                Section("Profile") {
                    TextField("Name", text: $viewModel.userName)
                }

                Section {
                    HStack {
                        Text("Ksh")
                            .foregroundStyle(.secondary)
                        TextField("Monthly budget",
                                  value: $viewModel.monthlyBudget,
                                  format: .number)
                            .keyboardType(.decimalPad)
                    }
                } header: {
                    Text("Monthly budget")
                } footer: {
                    Text("Your remaining balance is this amount minus what you spend in the month.")
                }
            }
            .font(.app(15))
            .scrollContentBackground(.hidden)
            .background(Color.appBackground)
            .navigationTitle("Account")
        }
    }
}

#Preview {
    AccountView()
        .environment(BudgetViewModel.preview)
}
