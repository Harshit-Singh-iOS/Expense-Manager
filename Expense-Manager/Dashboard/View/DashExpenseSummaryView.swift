//
//  DashExpenseSummaryView.swift
//  Expense-Manager
//
//  Created by Harshit on 1/27/26.
//

import SwiftUI
import SwiftData

struct DashExpenseSummaryView: View {
    @Query private var expense: [Expense]
    @State private var amount: Double = 0
        
    init(filter: Predicate<Expense>) {
        _expense = Query(filter: filter)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Summary")
                .font(.caption)
            Text(amount, format: .currency(code: "USD"))
        }
        .task {
            processAmount()
        }
    }
    
    private func processAmount() {
        var amount: Double = 0
        expense.forEach { amount += $0.amount }
        self.amount = amount
    }
}

#Preview {
    DashExpenseSummaryView(filter: #Predicate { _ in
        true
    })
}
