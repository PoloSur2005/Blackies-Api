import Fluent
import Vapor

struct LevelController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let levels = routes.grouped("levels")
        levels.get(use: index)
        levels.post(use: create)
        levels.group(":levelID") { level in
            level.get(use: show)
            level.put(use: update)
            level.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Level] {
        try await Level.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Level {
        let level = try req.content.decode(Level.self)
        try await level.save(on: req.db)
        return level
    }

    func show(req: Request) async throws -> Level {
        guard let levelID = req.parameters.get("levelID", as: Int.self),
              let level = try await Level.find(levelID, on: req.db) else {
            throw Abort(.notFound)
        }
        return level
    }

    func update(req: Request) async throws -> Level {
        guard let levelID = req.parameters.get("levelID", as: Int.self),
              let level = try await Level.find(levelID, on: req.db) else {
            throw Abort(.notFound)
        }
        let updated = try req.content.decode(Level.self)
        level.number = updated.number
        level.image = updated.image
        try await level.save(on: req.db)
        return level
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let levelID = req.parameters.get("levelID", as: Int.self),
              let level = try await Level.find(levelID, on: req.db) else {
            throw Abort(.notFound)
        }
        try await level.delete(on: req.db)
        return .noContent
    }
}

