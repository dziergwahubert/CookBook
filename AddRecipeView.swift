import SwiftUI
import SwiftData

struct AddRecipeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var ingredients = ""
    @State private var instructions = ""
    @State private var selectedImage: UIImage?
    @State private var showCamera = false
    @State private var showGallery = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Zdjęcie potrawy")) {
                    if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                            .listRowInsets(EdgeInsets())
                    }
                    HStack {
                        Button("Aparat") { showCamera = true }
                        Spacer()
                        Button("Galeria") { showGallery = true }
                    }
                    .buttonStyle(.bordered)
                }

                Section(header: Text("Informacje")) {
                    TextField("Nazwa przepisu", text: $title)
                    TextField("Składniki (po przecinku)", text: $ingredients)
                }

                Section(header: Text("Sposób przygotowania")) {
                    TextEditor(text: $instructions)
                        .frame(height: 100)
                    if instructions.isEmpty {
                        Text("Opisz tutaj jak przygotować danie...")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Nowy Przepis")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Anuluj") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Zapisz") {
                        saveRecipe()
                    }
                    .disabled(title.isEmpty)
                }
            }
            .sheet(isPresented: $showCamera) {
                ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
            }
            .sheet(isPresented: $showGallery) {
                ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
            }
        }
    }

    private func saveRecipe() {
        let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
        let newRecipe = Recipe(
            title: title,
            ingredients: ingredients,
            instructions: instructions,
            imageData: imageData
        )
        modelContext.insert(newRecipe)
        dismiss()
    }
}
