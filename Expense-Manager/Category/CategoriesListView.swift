//
//  CategoriesListView.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import SwiftUI
import SwiftData

struct CategoriesListView: View {
    @Environment(\.modelContext) private var moc
    @Query(sort: \ExpenseCategory.name) private var categories: [ExpenseCategory]
    @Query private var expenses: [Expense]
    
    @State private var showAddCategory = false
    @State private var categoryName = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    Text(category.name)
                }
                .onDelete(perform: deleteCategory)
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem {
                    Button {
                        showAddCategory = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .alert("Add category", isPresented: $showAddCategory) {
            TextField("Category", text: $categoryName)
            Button(role: .cancel) { }
            Button("Save") { addCategory() }
        }
        .overlay {
            if categories.isEmpty {
                Button {
                    showAddCategory = true
                } label: {
                    ContentUnavailableView("No categories", systemImage: "chart.pie", description: Text("Add a category."))
                }
                .tint(Color.primary)
            }
        }

    }
    
    func addCategory() {
        let categoryName = categoryName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !categoryName.isEmpty {
            let new = ExpenseCategory(id: .init(), name: categoryName)
            moc.insert(new)
            self.categoryName.removeAll()
        }
    }
    
    private func deleteCategory(at indexSet: IndexSet) {
        for index in indexSet {
            let category = categories[index]
            
            for expense in expenses where expense.category == category {
                expense.category = nil
                moc.insert(expense)
            }
            
            moc.delete(category)
        }
    }
}

#Preview {
    CategoriesListView()
}
