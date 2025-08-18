import SwiftUI
import SwiftData
import UniformTypeIdentifiers

//data management layer with the import and export button

struct DataManagementView: View {
    @Environment(\.modelContext) private var context
    @Query private var ingredients: [Ingredient]//list of ingredients fetched from SwiftData
    @Query private var techniques: [Technique]//list of techniques fetched from SwiftData
    
    @State private var showImporter = false
    @State private var exportURL: IdentifiableURL?//Needed to be an IdentifiableURL, made codable in wrapper
    @State private var showExporter = false
    
    var body: some View {//button definitions
        VStack(spacing: 20) {
            Button("Export to JSON") {
                exportData()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button("Import from JSON") {
                showImporter = true
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .navigationTitle("Data Management")
        .fileImporter(
            isPresented: $showImporter,
            allowedContentTypes: [.json],
            allowsMultipleSelection: false
        ) { result in
            handleImport(result: result)
        }
        .sheet(item: $exportURL) { identifiableURL in
            ActivityViewController(activityItems: [identifiableURL.url])
        }
    }
    
    // Export function
    func exportData() {
        let ingredientData = ingredients.map { IngredientData(name: $0.name, category: $0.category) }
        let techniqueData = techniques.map { TechniqueData(name: $0.name, category: $0.category) }
        
        let export = ExportData(ingredients: ingredientData, techniques: techniqueData)
        
        do {
            let data = try JSONEncoder().encode(export)
            let url = FileManager.default.temporaryDirectory.appendingPathComponent("MealData.json")
            try data.write(to: url)
            exportURL = IdentifiableURL(url: url)
        } catch {
            print("Export failed: \(error)")
        }
    }
    
    // Import function
    func handleImport(result: Result<[URL], Error>) {
        do {
            let urls = try result.get()
            guard let url = urls.first else { return }
            let data = try Data(contentsOf: url)
            let imported = try JSONDecoder().decode(ExportData.self, from: data)
            
            // Clear existing data on import, can be removed if not desirable
            ingredients.forEach { context.delete($0) }
            techniques.forEach { context.delete($0) }
            
            // Add new
            for ing in imported.ingredients {
                context.insert(Ingredient(name: ing.name, category: ing.category))
            }
            for tech in imported.techniques {
                context.insert(Technique(name: tech.name, category: tech.category))
            }
            
            try? context.save()
        } catch {
            print("Import failed: \(error)")
        }
    }
}

// UIKit wrapper for ActivityViewController applied like in the Apple documentation
struct ActivityViewController: UIViewControllerRepresentable {
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
