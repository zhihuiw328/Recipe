//
//  RecipeModel.swift
//  Recipe
//
//  Created by Zhihui Wan on 8/1/24.
//

import Foundation

struct RecipeModel: Decodable {
    private(set) var meals: [Meal]
    private(set) var selectedMeal: MealDetails?
    
    mutating func setMeals(_ setmeals: [Meal]) {
        meals = setmeals
    }
    
    mutating func selectMeal(_ select: MealDetails) {
        selectedMeal = select
    }
}

struct Meal: Identifiable, Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    var id: String {
        return idMeal
    }
}

struct MealWrapper: Decodable {
    let meals: [MealDetails]
}

struct MealDetails: Identifiable, Decodable {
    var id: String {
        return idMeal
    }
    
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    let strIngredient: [String]
    let strMeasure: [String]
    
    private struct MyCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int? = nil
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyCodingKeys.self)
    
        self.idMeal = try container.decode(String.self, forKey: MyCodingKeys(stringValue: "idMeal")!)
        self.strMeal = try container.decode(String.self, forKey: MyCodingKeys(stringValue: "strMeal")!)
        self.strMealThumb = try container.decode(String.self, forKey: MyCodingKeys(stringValue: "strMealThumb")!)
        self.strInstructions = try container.decode(String.self, forKey: MyCodingKeys(stringValue: "strInstructions")!)
        
        var ingredientArray = [String]()
        var measureArray = [String]()
        
        for i in 1...20 {
            
            if let ingredient = try container.decodeIfPresent(String.self, forKey: MyCodingKeys(stringValue: "strIngredient\(i)")!) {
                if ingredient != "" {
                    ingredientArray.append(ingredient)
                }
            }
            
            if let measure = try container.decodeIfPresent(String.self, forKey: MyCodingKeys(stringValue: "strMeasure\(i)")!) {
                if measure != " " {
                    measureArray.append(measure)
                }
            }
        
        }
        self.strIngredient = ingredientArray
        self.strMeasure = measureArray
       
        
    }
}
