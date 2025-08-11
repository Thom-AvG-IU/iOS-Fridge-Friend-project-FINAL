//Created for unittests
//Helper class allows unit tests to run automatically in Xcode with command + U


import Foundation

struct FridgeFriendHelper {
    static func generateMealIdea(
        ingredients: [IngredientData],
        techniques: [TechniqueData],
        categories: [String] = ["Protein", "Carb", "Vegetable"]
    ) -> String {
        var parts: [String] = []
        
        for category in categories {
            let ingredient = ingredients.filter { $0.category == category }.randomElement()?.name ?? "No ingredient"
            let technique = techniques.filter { $0.category == category }.randomElement()?.name ?? "No technique"
            parts.append("\(technique) \(ingredient)")
        }
        
        return parts.joined(separator: ", ")
    }
}
