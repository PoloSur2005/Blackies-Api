import Fluent
import Vapor

@preconcurrency
final class Momo: Model, Content, @unchecked Sendable {
    static let schema = "Momo"  // Usa mayúscula como en la tabla MySQL

    @ID(custom: "MomoID", generatedBy: .database)  // El campo id en MySQL es MomoID
    var id: Int?

    @Field(key: "Name")  // El campo es "Name" con mayúscula
    var name: String

    @Field(key: "Description")
    var description: String

    @Field(key: "Image")
    var image: String

    @Parent(key: "AutorID")
    var autor: Autor

    @Parent(key: "LevelID")
    var level: Level

    init() {}

    init(id: Int? = nil, name: String, description: String, image: String, autorID: Int, levelID: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.$autor.id = autorID
        self.$level.id = levelID
    }
}

