//
//  AddExpenseView.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

 // A form for adding a new budget
struct AddExpenseView: View {
    @Environment(BudgetViewModel.self) private var budget
    @Environment(\.dismiss) private var dismiss

    @State private var form = AddExpenseViewModel()
    @State private var savedExpense: Expense?

    var body: some View {
        NavigationStack {
            Group {
                if let savedExpense {
                    SuccessView(expense: savedExpense) { dismiss() }
                        .transition(.scale.combined(with: .opacity))
                } else {
                    formContent
                }
            }
            .animation(.spring, value: savedExpense != nil)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.appBackground)
            .navigationTitle(savedExpense == nil ? "Add New Budget Item" : "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(savedExpense == nil ? "Cancel" : "Close") { dismiss() }
                        .tint(.appSecondary)
                }
            }
        }
    }

    private var formContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                field("Category") {
                    Picker("Category", selection: $form.category) {
                        ForEach(ExpenseCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                field("Item Name") {
                    TextField("Item name", text: $form.itemName)
                }

                field("Allocation") {
                    HStack {
                        Text("Ksh")
                            .foregroundStyle(.secondary)
                        TextField("0", text: $form.amountText)
                            .keyboardType(.decimalPad)
                    }
                }

                Button(action: save) {
                    Text("Create new Budget Item")
                        .font(.app(16))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(form.isValid ? Color.appPrimary : Color.gray.opacity(0.4))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .disabled(!form.isValid)
                .padding(.top, 8)
            }
            .padding()
        }
    }

    
    private func field<Content: View>(_ title: String,
                                      @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.app(13))
                .foregroundStyle(.secondary)
            content()
                .font(.app(15))
                .padding(12)
                .background(Color.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
        }
    }

    private func save() {
        guard form.isValid, let amount = form.amount else { return }
        savedExpense = budget.addExpense(name: form.trimmedName,
                                         category: form.category,
                                         amount: amount)
    }
}

#Preview {
    AddExpenseView()
        .environment(BudgetViewModel.preview)
}
