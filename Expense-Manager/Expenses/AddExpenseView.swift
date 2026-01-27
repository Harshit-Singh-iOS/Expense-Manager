//
//  AddExpenseView.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.modelContext) private var moc
    @Environment(\.dismiss) private var dismiss
    
    //@State private var categories: [ExpenseCategory] = [.init(id: UUID(), name: "asfasf"), .init(id: .init(), name: "asfs")] // For testing
    @Query(sort: \ExpenseCategory.name) private var categories: [ExpenseCategory]
    
    @State private var date: Date = .now
    @State private var name: String = ""
    @State private var amount: Double = 0
    @State private var currency: String = "USD"
    @State private var category: ExpenseCategory?
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Add expense")
                .bold()
                .padding()
            
            HStack {
                Text("Name")
                    .bold()
                
                Spacer()
                TextField("Table", text: $name)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
            }
            
            HStack(spacing: 0) {
                Text("Amount")
                    .bold()
                
                TextField("USD", text: $currency)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 60)
                    .disabled(true)
                
                Spacer()
                
                TextField("$0.00", value: $amount, format: .currency(code: "USD"))
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .frame(width: 100)
            }
            
            HStack {
                Text("Category")
                    .bold()
                
                Spacer()
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.id) { category in
                        Text(category.name)
                            .tag(category)
                    }
                }
                .pickerStyle(.menu)
            }
            
            HStack {
                Text("Date")
                    .bold()
                Spacer()
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
            }
            
            Spacer()
            
            Button("Save") {
                saveExpense()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    private func saveExpense() {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty, let category else { return }
        
        let newExpense = Expense(id: UUID(), name: name, category: category, amount: amount, currency: currency, dateOfExpense: date, lastUpdated: .now)

        moc.insert(newExpense)
        dismiss()
    }
}

#Preview {
    @Previewable @State var showSheet = true
    
    Button("Parent view") { showSheet = true }
        .sheet(isPresented: $showSheet) {
            AddExpenseView()
                .presentationDetents([.medium])
        }
    
}
