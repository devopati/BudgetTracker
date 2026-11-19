# Budget Tracker (SwiftUI)

A monthly budget tracker. Everything is stored on the device.

## Stack

- Swift + SwiftUI (iOS 17+)
- MVVM
- SwiftData for the local database
- Swift Charts for the Reports bar chart

## Folder structure

```
BudgetTracker/
  App/            App entry point, creates the database and the shared ViewModel
  Models/         Expense (@Model, saved locally), ExpenseCategory
  ViewModels/     BudgetViewModel (all budget logic), AddExpenseViewModel (form + validation)
  Views/
    Main/         MainTabView + custom BottomBar with the centre "+" button
    Home/         Balance card, monthly spend breakdown, recent transactions
    AddExpense/   Add form and success screen
    Budgets/      Per category totals and all expenses
    Reports/      Bar chart and budget usage
    Account/      Name and monthly budget settings
    Components/   Reusable TransactionRowView
  Theme/          Brand colours, font helper, card style, category colours and icons
  Utilities/      Number nd date formatting
  Preview/        In-memory sample data for Xxcode previews
```

## How it works

1. The user adds an expense from the "+" button btom bar.
2. `BudgetViewModel` saves it with SwiftData and refreshes its list.
3. Every screen reads from the same ViewModel, so Home, Budgets and Reports update together.
4. Remaining balance = monthly budget - total spent in the selected month.
5. The monthly budget and name are editable in Account.

## My Design decisions

- **One shared ViewModel** injected through the environment..
- **Views contain no business logic**: totals, filtering and saving all live in the ViewModel.
- **Category colours and icons live in the Theme layer** so the model stays UI-independent.
- **Custom bottom bar** to match the design's raised centre button, with fade transitions between tabs.
- **Responsive**: flexible frames, minimumScaleFactor.
- **Amounts use Double** for simplicity real money movement I would use `Decimal`.


