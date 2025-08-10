import SwiftData
import SwiftUI

@main
struct MealPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack { IngredientsView() }
                    .tabItem { Label("Ingredients", systemImage: "leaf") }
                
                NavigationStack { TechniquesView() }
                    .tabItem { Label("Techniques", systemImage: "fork.knife") }
                
                NavigationStack { MealSuggestionView() }
                    .tabItem { Label("Meal Idea", systemImage: "lightbulb") }
                
                NavigationStack { DataManagementView() }
                    .tabItem { Label("Data", systemImage: "square.and.arrow.up") }
            }
        }
        .modelContainer(for: [Ingredient.self, Technique.self])
    }
}
