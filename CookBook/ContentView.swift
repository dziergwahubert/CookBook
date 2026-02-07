import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.dateAdded, order: .reverse) private var recipes: [Recipe]
    @State private var showAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink {
                        RecipeDetailView(recipe: recipe)
                    } label: {
                        HStack {
                            if let data = recipe.imageData, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } else {
                                Image(systemName: "fork.knife.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(recipe.title)
                                    .font(.headline)
                                Text(recipe.ingredients)
                                    .font(.caption)
                                    .lineLimit(1)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("CookBook")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddSheet = true }) {
                        Label("Dodaj", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddRecipeView()
            }
            .overlay {
                if recipes.isEmpty {
                    ContentUnavailableView(
                        "Brak przepisów",
                        systemImage: "fork.knife",
                        description: Text("Dodaj swój pierwszy przepis klikając +")
                    )
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
        }
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let data = recipe.imageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .overlay(Image(systemName: "photo").font(.largeTitle))
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(recipe.title)
                        .font(.largeTitle)
                        .bold()
                    
                    Divider()
                    
                    Text("Składniki")
                        .font(.title2)
                        .bold()
                    Text(recipe.ingredients)
                    
                    Divider()
                    
                    Text("Przygotowanie")
                        .font(.title2)
                        .bold()
                    Text(recipe.instructions)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
