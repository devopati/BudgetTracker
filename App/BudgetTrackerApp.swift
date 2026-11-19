//
//  BudgetTrackerApp.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI
import SwiftData

@main
struct BudgetTrackerApp: App {
    private let container: ModelContainer
    @State private var viewModel: BudgetViewModel

    init() {
        let container: ModelContainer
        do {
            container = try ModelContainer(for: Expense.self)
        } catch {
            fatalError("Could not create the local database: \(error)")
        }
        self.container = container
        _viewModel = State(initialValue: BudgetViewModel(context: container.mainContext))
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(viewModel)
        }
        .modelContainer(container)
    }
}
