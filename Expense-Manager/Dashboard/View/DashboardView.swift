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
    @State private var vm: DashboardVM = .init()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Picker("Period", selection: $vm.expensePeriod) {
                    ForEach(ExpensePeriod.allCases, id: \.self) { period in
                        Text(period.title)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: vm.expensePeriod) { _,_ in
                    vm.setupSummaryPredicate()
                }
                
                HStack {
                    DashExpenseSummaryView(filter: vm.summaryPredicate)
                    Spacer()
                }
                .padding(.top, 16)

                Spacer()
            }
            .padding()
            .navigationTitle("Dashboard")
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
