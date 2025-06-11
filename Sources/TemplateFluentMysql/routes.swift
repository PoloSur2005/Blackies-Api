import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    // Registra tus controladores aquí
    try app.register(collection: LevelController())
    try app.register(collection: AutorController())
    try app.register(collection: MomoController())
}
