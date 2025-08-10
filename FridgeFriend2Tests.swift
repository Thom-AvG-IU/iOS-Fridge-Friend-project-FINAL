import XCTest
@testable import FridgeFriend2

final class MealPlannerTests: XCTestCase {
    
    func testMealGenerationProducesString() {
        let ingredients = [
            IngredientData(name: "Chicken", category: "Protein"),
            IngredientData(name: "Rice", category: "Carb"),
            IngredientData(name: "Broccoli", category: "Vegetable")
        ]
        
        let techniques = [
            TechniqueData(name: "Grilled", category: "Protein"),
            TechniqueData(name: "Steamed", category: "Carb"),
            TechniqueData(name: "Roasted", category: "Vegetable")
        ]
        
        let meal = FridgeFriendHelper.generateMealIdea(ingredients: ingredients, techniques: techniques)
        
        XCTAssertFalse(meal.isEmpty, "Meal idea should not be empty")
        XCTAssertTrue(meal.contains("Chicken") || meal.contains("Rice") || meal.contains("Broccoli"), "Meal should include at least one known ingredient")
    }
    
    func testExportDataEncodingAndDecoding() throws {
        let exportData = ExportData(
            ingredients: [IngredientData(name: "Beef", category: "Protein")],
            techniques: [TechniqueData(name: "Fried", category: "Protein")]
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(exportData)
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(ExportData.self, from: data)
        
        XCTAssertEqual(decoded.ingredients.first?.name, "Beef")
        XCTAssertEqual(decoded.techniques.first?.name, "Fried")
    }
}
