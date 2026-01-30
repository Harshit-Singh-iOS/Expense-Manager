//
//  DashExpenseCategoryView.swift
//  Expense-Manager
//
//  Created by Harshit on 1/29/26.
//

import SwiftUI
import SwiftData

struct DashExpenseCategoryView: View {
    @Query private var expenses: [Expense]
    @State private var categoryAmounts: [(ExpenseCategory, Double)] = []
    
    private let unknownCategory = ExpenseCategory(id: .init(), name: "Unknown")
    
    init(filter: Predicate<Expense>) {
        _expenses = Query(filter: filter)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Expense")
                .font(.headline)
                .padding(.horizontal, 16)
            ScrollView(.horizontal) {
                HStack(spacing: 24) {
                    ForEach(categoryAmounts, id: \.0.id) { cat in
                        VStack(spacing: 8) {
                            Text(cat.0.name)
                            Text(cat.1, format: .currency(code: "USD"))
                        }
                        .padding()
                        .frame(width: 140, height: 140)
                        .glassEffect(.regular, in: .rect(cornerRadius: 16))
                    }
                }
                .padding([.top, .horizontal])
                .padding(.bottom, 36)
            }
            .scrollIndicators(.hidden)
        }
        .task {
            prepareCategories()
        }
    }
    
    private func prepareCategories() {
        var new: [ExpenseCategory: Double] = [:]
        
        for expense in expenses {
            new[expense.category ?? unknownCategory, default: 0] += expense.amount
        }
        self.categoryAmounts = new.sorted(by: { $0.key.name < $1.key.name })
    }
}

#Preview {
//    var new: [ExpenseCategory: Double] = [
//        .init(id: .init(), name: "Rent"): 1423.3,
//        .init(id: .init(), name: "Grocery"): 223.3,
//        .init(id: .init(), name: "Travel"): 415.34,
//        .init(id: .init(), name: "Phone"): 98,
//    ]
    DashExpenseCategoryView(filter: #Predicate { _ in
        true
    })
}
