//
//  Formatters.swift
//  BudgetTracker
//
//  Created by Dev on 19/11/2026.
//

import Foundation

extension Double {
    // 2000 to be Ksh. 2000
    var ksh: String {
        "Ksh. " + formatted(.number.precision(.fractionLength(1)))
    }

    // 2000 to be 2,000.0
    var amountText: String {
        formatted(.number.precision(.fractionLength(1)))
    }
}

extension Date {
    // "Norvember"
    var monthName: String {
        formatted(.dateTime.month(.wide))
    }
}
