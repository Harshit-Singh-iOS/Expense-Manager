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
    
    @State private var showAddCategory = false
    @State private var categoryName = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    Text(category.name)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let item = categories[index]
                        moc.delete(item)
                    }
                }
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

    }
    
    func addCategory() {
        let categoryName = categoryName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !categoryName.isEmpty {
            let new = ExpenseCategory(id: .init(), name: categoryName)
            moc.insert(new)
            self.categoryName.removeAll()
        }
    }
}

#Preview {
    CategoriesListView()
}
