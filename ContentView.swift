import SwiftUI
import SwiftData

struct IngredientsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Ingredient.name) private var ingredients: [Ingredient] //query to SwiftData for all available ingredients
    
    @State private var newIngredient = "" //newIngredient as a var to store new ingredient typed by user to avoid storing empty value
    @State private var selectedCategory = "Protein" //begin value as protein
    
    let categories = ["Protein", "Carb", "Vegetable"]
    
    var body: some View {
        VStack {//structure of the app in a vertical stack
            HStack {//vertical stack with the textbox and the add button
                TextField("Enter ingredient", text: $newIngredient)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Picker("", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { Text($0) }
                }
                .pickerStyle(MenuPickerStyle())
                Button("Add") {
                    guard !newIngredient.isEmpty else { return }
                    let ingredient = Ingredient(name: newIngredient, category: selectedCategory)
                    context.insert(ingredient)
                    try? context.save()
                    newIngredient = ""
                }
            }
            .padding()
            
            List {
                ForEach(categories, id: \.self) { category in
                    Section(header: Text(category)) {
                        ForEach(ingredients.filter { $0.category == category }) { item in
                            Text(item.name)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let item = ingredients.filter { $0.category == category }[index]
                                context.delete(item)
                            }
                            try? context.save()
                        }
                    }
                }
            }
        }
        .navigationTitle("Ingredients")
    }
}
