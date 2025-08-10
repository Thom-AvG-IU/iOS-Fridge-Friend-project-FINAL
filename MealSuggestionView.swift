//
//  MealSuggestionView.swift
//  FridgeFriend2
//
//  Created by Thom Alting von Geusau on 10/08/2025.
//

import SwiftData
import SwiftUI

struct MealSuggestionView: View {
    @Query private var ingredients: [Ingredient]
    @Query private var techniques: [Technique]
    
    @State private var mealIdea = ""
    
    let categories = ["Protein", "Carb", "Vegetable"]
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: generateMealIdea) {
                Text("Suggest Meal")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            if !mealIdea.isEmpty {
                Text(mealIdea)
                    .font(.title2)
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
        .navigationTitle("Meal Idea")
    }
    
    func generateMealIdea() {
        var parts: [String] = []
        
        for category in categories {
            let ingredient = ingredients.filter { $0.category == category }.randomElement()?.name ?? "No ingredient"
            let technique = techniques.filter { $0.category == category }.randomElement()?.name ?? "No technique"
            parts.append("\(technique) \(ingredient)")
        }
        
        mealIdea = parts.joined(separator: ", ")
    }
}
