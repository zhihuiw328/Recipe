//
//  NetworkManager.swift
//  Recipe
//
//  Created by Zhihui Wan on 8/3/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    
    private init() {}
    
    func fetchMeals() async throws -> [Meal] {
        let url = URL(string: "\(baseURL)filter.php?c=Dessert")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(RecipeModel.self, from: data)
        return decodedResponse.meals.sorted{ $0.strMeal < $1.strMeal }
    }
    
    func fetchMeal(id: String) async throws -> MealDetails {
        let url = URL(string: "\(baseURL)lookup.php?i=\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(MealWrapper.self, from: data)
        return decodedResponse.meals.first!
    }
}
