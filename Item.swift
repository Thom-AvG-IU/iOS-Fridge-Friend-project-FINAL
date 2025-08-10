import SwiftData
import Foundation

@Model
class Ingredient {
    var name: String
    var category: String // "Protein", "Carb", "Vegetable"
    
    init(name: String, category: String) {
        self.name = name
        self.category = category
    }
}

@Model
class Technique {
    var name: String
    var category: String // "Protein", "Carb", "Vegetable"
    
    init(name: String, category: String) {
        self.name = name
        self.category = category
    }
}


struct IngredientData: Codable {
    var name: String
    var category: String
}

struct TechniqueData: Codable {
    var name: String
    var category: String
}

struct ExportData: Codable {
    var ingredients: [IngredientData]
    var techniques: [TechniqueData]
}

struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}
