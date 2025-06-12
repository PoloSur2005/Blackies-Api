import Vapor
import Fluent

struct AutorController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let autors = routes.grouped("autors")
        autors.get(":autorID", use: show)
        autors.put(":autorID", use: update)
        autors.delete(":autorID", use: delete)
        // Opcional: podrías agregar index y create si quieres
    }

    func show(req: Request) async throws -> Autor {
        guard let id = req.parameters.get("autorID", as: Int.self),
              let autor = try await Autor.find(id, on: req.db) else {
            throw Abort(.notFound)
        }
        return autor
    }

    func update(req: Request) async throws -> Autor {
        let updated = try req.content.decode(Autor.self)
        guard let id = req.parameters.get("autorID", as: Int.self),
              let autor = try await Autor.find(id, on: req.db) else {
            throw Abort(.notFound)
        }
        autor.name = updated.name
        autor.description = updated.description
        try await autor.save(on: req.db)
        return autor
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let id = req.parameters.get("autorID", as: Int.self),
              let autor = try await Autor.find(id, on: req.db) else {
            throw Abort(.notFound)
        }
        try await autor.delete(on: req.db)
        return .noContent
    }
}

