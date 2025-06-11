import Fluent
import Vapor

@preconcurrency
final class Momo: Model, Content, @unchecked Sendable {
    static let schema = "momo"

    @ID(custom: "id", generatedBy: .database)
    var id: Int?

    @Field(key: "name")
    var name: String

    @Field(key: "description")
    var description: String

    @Field(key: "image")
    var image: String

    @Parent(key: "autorID")
    var autor: Autor

    @Parent(key: "levelID")
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

