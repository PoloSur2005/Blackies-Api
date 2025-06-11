import Fluent
import Vapor

@preconcurrency
final class Autor: Model, Content, @unchecked Sendable {
    static let schema = "Autor"

    @ID(custom: "id", generatedBy: .database)
    var id: Int?

    @Field(key: "Name")
    var name: String

    @Field(key: "Description")
    var description: String

    init() {}

    init(id: Int? = nil, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
