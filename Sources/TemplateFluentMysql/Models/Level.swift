import Fluent
import Vapor

@preconcurrency
final class Level: Model, Content, @unchecked Sendable {
    static let schema = "Level"

    @ID(custom: "LevelID", generatedBy: .database)
    var id: Int?

    @Field(key: "Number")
    var number: Int

    @Field(key: "Image")
    var image: String

    init() {}

    init(id: Int? = nil, number: Int, image: String) {
        self.id = id
        self.number = number
        self.image = image
    }
}

