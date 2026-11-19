//
//  BalanceCardView.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import SwiftUI

//green card showing what is left of the monthly budget
struct BalanceCardView: View {
    let remaining: Double

    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(remaining.amountText)
                    .font(.app(44, relativeTo: .largeTitle))
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)      // shrinks on small screens instead of cutting off
                    .contentTransition(.numericText())
                Text("Ksh.")
                    .font(.app(14))
                    .fontWeight(.semibold)
            }

            Text(remaining >= 0
                 ? "remaining on your monthly budget"
                 : "over your monthly budget")
                .font(.app(15))
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .padding(.horizontal)
        .background(
            LinearGradient(colors: [.appPrimary, .appSecondary],
                           startPoint: .leading, endPoint: .trailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .animation(.default, value: remaining)
    }
}

#Preview {
    BalanceCardView(remaining: 183_000)
        .padding()
}
