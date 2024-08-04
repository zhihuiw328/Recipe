//
//  RecipeApp.swift
//  Recipe
//
//  Created by Zhihui Wan on 8/1/24.
//

import SwiftUI

@main
struct RecipeApp: App {
    @StateObject var recipe = RecipeViewModel()
    var body: some Scene {
        WindowGroup {
            MealListView(viewModel: recipe)
        }
    }
}
