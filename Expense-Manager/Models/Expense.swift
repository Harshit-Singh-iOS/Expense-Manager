//
//  Expense.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import Foundation
import SwiftData

@Model
class Expense {
    var id: UUID
    var name: String
    var category: ExpenseCategory?
    var amount: Double
    var currency: String
    var dateOfExpense: Date
    var lastUpdated: Date
    
    init(id: UUID, name: String, category: ExpenseCategory?, amount: Double, currency: String, dateOfExpense: Date, lastUpdated: Date) {
        self.id = id
        self.name = name
        self.category = category
        self.amount = amount
        self.currency = currency
        self.dateOfExpense = dateOfExpense
        self.lastUpdated = lastUpdated
    }
}
