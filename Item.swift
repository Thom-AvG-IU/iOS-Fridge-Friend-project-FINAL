import SwiftData
import Foundation

//item object is used to set up the data model, which allows for storing data across run instances.

@Model
class Ingredient {
    var name: String//"chicken"
    var category: String // "Protein", "Carb", "Vegetable"
    
    init(name: String, category: String) {
        self.name = name
        self.category = category
    }
}

@Model
class Technique {
    var name: String//"boiled"
    var category: String // "Protein", "Carb", "Vegetable"
    
    init(name: String, category: String) {
        self.name = name
        self.category = category
    }
}

//creation of schema as defined by model
struct IngredientData: Codable {
    var name: String
    var category: String
}
//creation of schema as defined by model
struct TechniqueData: Codable {
    var name: String
    var category: String
}

struct ExportData: Codable {//used for transferring data
    var ingredients: [IngredientData]
    var techniques: [TechniqueData]
}

struct IdentifiableURL: Identifiable {//used for transferring of data
    let id = UUID()
    let url: URL
}
