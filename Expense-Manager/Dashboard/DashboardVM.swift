//
//  DashboardVM.swift
//  Expense-Manager
//
//  Created by Harshit on 1/27/26.
//

import Foundation

enum ExpensePeriod: Hashable, CaseIterable {
    case month, year
    
    var title: String {
        switch self {
        case .month:
            "Month"
        case .year:
            "Year"
        }
    }
}

@Observable
class DashboardVM {
    var expensePeriod: ExpensePeriod = .month
    var summaryPredicate: Predicate<Expense> = #Predicate { _ in true }
    
    init() {
        setupSummaryPredicate()
    }
    
    func setupSummaryPredicate() {
        let currentDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: .now)

        var startDateComp = DateComponents()
        var endDateComp = DateComponents()
        
        startDateComp.year = currentDateComponent.year ?? 2000
        endDateComp.year = currentDateComponent.year ?? 2000
        
        switch expensePeriod {
        case .month:
            startDateComp.day = 1
            startDateComp.month = currentDateComponent.month ?? 1
            
            endDateComp.day = Calendar.current.range(of: .day, in: .month, for: .now)?.count ?? 30
            endDateComp.month = currentDateComponent.month ?? 1
            
        case .year:
            startDateComp.month = 1
            startDateComp.day = 1
            
            endDateComp.month = 12
            endDateComp.day = 31
        }
        
        guard let startDate = Calendar.current.date(from: startDateComp),
              let endDate = Calendar.current.date(from: endDateComp) else {
            return
        }
        
        print("startDate", startDate, "endDate", endDate)
        summaryPredicate = #Predicate { expense in
            expense.dateOfExpense >= startDate &&
            expense.dateOfExpense <= endDate
        }
    }
    
}
