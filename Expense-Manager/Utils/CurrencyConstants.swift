//
//  CurrencyConstants.swift
//  Expense-Manager
//
//  Created by Harshit on 1/29/26.
//

import Foundation

enum Currency: String, CaseIterable {
    case USD
    
    var code: String {
        self.rawValue
    }
}
