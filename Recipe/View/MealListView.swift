//
//  ContentView.swift
//  Recipe
//
//  Created by Zhihui Wan on 8/1/24.
//

import SwiftUI

struct MealListView: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        NavigationView {
            MealsView(viewModel: viewModel)
        }
    }
}

struct MealsView: View {
    @ObservedObject var viewModel: RecipeViewModel
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.meals) { meal in
                    NavigationLink(destination: MealDetailView(id: meal.idMeal, viewModel: viewModel)) {
                        CardView(meal.idMeal, meal.strMeal, meal.strMealThumb)
                    }
                }
            }
            .padding()
        }
        .task {
            await viewModel.loadMeals()
        }
    }
}

struct CardView: View {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    init(_ idMeal: String, _ strMeal: String, _ strMealThumb: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: strMealThumb))
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(idMeal)
                .font(.subheadline)
            Spacer()
            Text(strMeal)
                .font(.headline)
                .fontWeight(.bold)
            
        }
        .padding()
    }
}


#Preview {
    MealListView(viewModel: RecipeViewModel())
}
