//
//  MealDetailView.swift
//  Recipe
//
//  Created by Zhihui Wan on 8/3/24.
//

import SwiftUI

struct MealDetailView: View {
    let id: String
    @ObservedObject var viewModel: RecipeViewModel
    var body: some View {
        ScrollView {
            DetailView(viewModel: viewModel)
                .padding()
        }
        .task {
            await viewModel.selectMeal(id: id)
        }
    }
}

struct DetailView: View {
    @ObservedObject var viewModel: RecipeViewModel
    var body: some View {
        VStack {
            if let mealDetail = viewModel.mealDetails {
                Text(mealDetail.strMeal)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 300)
                .cornerRadius(12)

                Text("Instructions")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(mealDetail.strInstructions)
                    .font(.body)
                
                Text("Ingredients")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                ForEach(Array(zip(mealDetail.strIngredient, mealDetail.strMeasure)).enumerated().map({ $0 }), id: \.0)
                    { index, ingredientMeasure in
                        let (ingredient, measure) = ingredientMeasure
                        HStack {
                            Text(ingredient)
                                .fontWeight(.medium)
                            Text(measure)
                        }
                        .padding(.vertical, 4)
                    }
                
            } else {
                Text("Meal details not available")
            }
        }
    }
}
