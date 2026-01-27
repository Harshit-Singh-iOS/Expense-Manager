//
//  DashboardView.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.modelContext) var moc
    @State private var showAddExpenseSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Dashboard")
                
            }
            .toolbar {
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
    DashboardView()
}
