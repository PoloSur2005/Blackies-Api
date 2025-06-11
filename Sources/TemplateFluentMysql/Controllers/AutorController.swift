import Fluent
import Vapor

struct AutorController: RouteCollection {
    func boot(routes:  any RoutesBuilder) throws {
        let autors = routes.grouped("autors")
        autors.get(use: index)
        autors.post(use: create)
        autors.group(":autorID") { autor in
            autor.get(use: show)
            autor.put(use: update)
            autor.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Autor] {
        try await Autor.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Autor {
        let autor = try req.content.decode(Autor.self)
        try await autor.save(on: req.db)
        return autor
    }

    func show(req: Request) async throws -> Autor {
        guard let autor = try await Autor.find(req.parameters.get("autorID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return autor
    }

    func update(req: Request) async throws -> Autor {
        let updated = try req.content.decode(Autor.self)
        guard let autor = try await Autor.find(req.parameters.get("autorID"), on: req.db) else {
            throw Abort(.notFound)
        }
        autor.name = updated.name
        autor.description = updated.description
        try await autor.save(on: req.db)
        return autor
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let autor = try await Autor.find(req.parameters.get("autorID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await autor.delete(on: req.db)
        return .noContent
    }
}
