//
//  ExerciseApp.swift
//  Exercise
//
//  Created by Harshit on 1/26/26.
//

import SwiftUI
import SwiftData

@main
struct ExerciseApp: App {
    var body: some Scene {
        WindowGroup {
            ExpenseBaseTabView()
        }
        .modelContainer(for: [
            Expense.self,
            ExpenseCategory.self
        ])
    }
}
