//
//  ContentView.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import SwiftUI
import SwiftData

struct ExpenseListView: View {
    @Environment(\.modelContext) var moc
    @Query(sort: [SortDescriptor(\Expense.dateOfExpense, order: .reverse)]) private var expenseList: [Expense]
    @Query private var categories: [ExpenseCategory]
    
    @State private var showAddExpenseSheet = false
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenseList) { expense in
                    ExpenseItemView(expense: expense)
                }
                .onDelete { indexSet in
                    for offset in indexSet {
                        let item = expenseList[offset]
                        moc.delete(item)
                    }
                }
            }
            .navigationTitle("Expense")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "lightbulb.led.wide")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddExpenseSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showAddExpenseSheet) {
            AddExpenseView()
                .presentationDetents([.medium])
        }
    }
}


#Preview {
    ExpenseListView()
}
