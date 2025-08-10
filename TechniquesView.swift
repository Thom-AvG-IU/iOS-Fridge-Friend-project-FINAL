//
//  Techniques.swift
//  FridgeFriend2
//
//  Created by Thom Alting von Geusau on 10/08/2025.
//
import SwiftData
import SwiftUI

struct TechniquesView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Technique.name) private var techniques: [Technique]
    
    @State private var newTechnique = ""
    @State private var selectedCategory = "Protein"
    
    let categories = ["Protein", "Carb", "Vegetable"]
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter technique", text: $newTechnique)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Picker("", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { Text($0) }
                }
                .pickerStyle(MenuPickerStyle())
                Button("Add") {
                    guard !newTechnique.isEmpty else { return }
                    let technique = Technique(name: newTechnique, category: selectedCategory)
                    context.insert(technique)
                    try? context.save()
                    newTechnique = ""
                }
            }
            .padding()
            
            List {
                ForEach(categories, id: \.self) { category in
                    Section(header: Text(category)) {
                        ForEach(techniques.filter { $0.category == category }) { item in
                            Text(item.name)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let item = techniques.filter { $0.category == category }[index]
                                context.delete(item)
                            }
                            try? context.save()
                        }
                    }
                }
            }
        }
        .navigationTitle("Techniques")
    }
}
