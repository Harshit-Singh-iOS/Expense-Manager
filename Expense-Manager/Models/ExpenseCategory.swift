//
//  ExpenseCategory.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import Foundation
import SwiftData

@Model
class ExpenseCategory {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
