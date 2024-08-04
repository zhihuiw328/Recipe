//
//  RecipeViewModel.swift
//  Recipe
//
//  Created by Zhihui Wan on 8/1/24.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published private var model: RecipeModel = RecipeModel(meals: [])
    
    var meals: [Meal] {
        return model.meals
    }
    
    var mealDetails: MealDetails? {
        return model.selectedMeal
    }
    
    func loadMeals() async {
        do {
            let loadedMeals = try await NetworkManager.shared.fetchMeals()
            model.setMeals(loadedMeals)
        } catch {
            print("Error loading meals: \(error)")
        }
    }
    
    func selectMeal(id: String) async {
        do {
            let mealDetail = try await NetworkManager.shared.fetchMeal(id: id)
            model.selectMeal(mealDetail)
        } catch {
            print("Error select meal: \(error)")
        }
    }
    
}

