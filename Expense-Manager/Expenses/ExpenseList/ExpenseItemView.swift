//
//  ExpenseItemView.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import SwiftUI
import SwiftData

struct ExpenseItemView: View {
    var expense: Expense
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(expense.dateOfExpense, format: .dateTime.day().month().year())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(expense.amount, format: .currency(code: expense.currency))
                    .font(.callout)
                    .foregroundStyle(.primary)
                
                if let name = expense.category?.name {
                    Text(name)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    ExpenseItemView(expense: .init(id: .init(), name: "Table", category: .init(id: .init(), name: "Shopping"), amount: 35.43, currency: Currency.USD.code, dateOfExpense: .now, lastUpdated: .now))
}
