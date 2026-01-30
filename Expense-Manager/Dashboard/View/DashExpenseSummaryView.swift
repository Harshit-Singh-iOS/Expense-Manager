//
//  DashExpenseSummaryView.swift
//  Expense-Manager
//
//  Created by Harshit on 1/27/26.
//

import SwiftUI
import SwiftData

struct DashExpenseSummaryView: View {
    @Query private var expenses: [Expense]
    @State private var amount: Double = 0
        
    init(filter: Predicate<Expense>) {
        _expenses = Query(filter: filter)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Summary")
                .font(.headline)
            Text(amount, format: .currency(code: Currency.USD.code))
        }
        .task {
            processAmount()
        }
    }
    
    private func processAmount() {
        var amount: Double = 0
        expenses.forEach { amount += $0.amount }
        self.amount = amount
    }
}

#Preview {
    DashExpenseSummaryView(filter: #Predicate { _ in
        true
    })
}
