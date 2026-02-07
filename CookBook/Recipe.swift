import Foundation
import SwiftData

@Model
final class Recipe {
    var title: String
    var ingredients: String
    var instructions: String
    var dateAdded: Date
    @Attribute(.externalStorage) var imageData: Data?

    init(title: String, ingredients: String, instructions: String, imageData: Data? = nil) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
        self.dateAdded = Date()
        self.imageData = imageData
    }
}
