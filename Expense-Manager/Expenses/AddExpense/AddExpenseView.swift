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
    @State private var selectedCurrency: Currency = .USD
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
                
                Spacer()
                
                TextField("$0.00", value: $amount, format: .currency(code: selectedCurrency.code))
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .frame(width: 100)
            }
            
            HStack {
                Text("Currency*")
                    .bold()
                
                Spacer()
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(Currency.allCases, id: \.self) { item in
                        Text(item.code)
                    }
                }
                .pickerStyle(.menu)
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
            
            HStack {
                Text("*Update default currency in settings.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.bottom)
            
            Button("Save") {
                saveExpense()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .task {
            setupDefaultCurrency()
        }
    }
    
    func setupDefaultCurrency() {
        @AppStorage(UserDefaultString.UserCurrentSelectedCurrency.rawValue) var currencyCode = Currency.USD.code
        self.selectedCurrency = Currency(rawValue: currencyCode) ?? .USD
    }
    
    private func saveExpense() {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty, let category else { return }
        
        let newExpense = Expense(id: UUID(), name: name, category: category, amount: amount, currency: selectedCurrency.code, dateOfExpense: date, lastUpdated: .now)

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
