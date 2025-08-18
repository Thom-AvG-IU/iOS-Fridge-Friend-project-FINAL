import SwiftData
import SwiftUI

struct MealSuggestionView: View {
    @Query private var ingredients: [Ingredient]//fetch data from SwiftData
    @Query private var techniques: [Technique]
    
    @State private var mealIdea = ""//default empty
    
    let categories = ["Protein", "Carb", "Vegetable"]
    
    var body: some View {//view to generate random meal idea
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
    
    func generateMealIdea() {//function called by button
        var parts: [String] = []//functions iterates through defined categories and takes a random element from each category for
                                //a technique and an ingredient to create a simple sumup divided by a comma for a meal idea
        
        for category in categories {
            let ingredient = ingredients.filter { $0.category == category }.randomElement()?.name ?? "No ingredient"
            let technique = techniques.filter { $0.category == category }.randomElement()?.name ?? "No technique"
            parts.append("\(technique) \(ingredient)")
        }
        
        mealIdea = parts.joined(separator: ", ")
    }
}
