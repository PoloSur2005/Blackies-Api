import Fluent
import Vapor

struct MomoController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let momos = routes.grouped("momos")
        momos.get(use: index)
        momos.post(use: create)
        momos.group(":momoID") { momo in
            momo.get(use: show)
            momo.put(use: update)
            momo.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Momo] {
        try await Momo.query(on: req.db)
            .with(\.$autor)
            .with(\.$level)
            .all()
    }

    func create(req: Request) async throws -> Momo {
        let momo = try req.content.decode(Momo.self)
        try await momo.save(on: req.db)
        return momo
    }

    func show(req: Request) async throws -> Momo {
        guard let momoID = req.parameters.get("momoID", as: Int.self) else {
            throw Abort(.badRequest)
        }
        guard let momo = try await Momo.query(on: req.db)
            .filter(\.$id == momoID)
            .with(\.$autor)
            .with(\.$level)
            .first()
        else {
            throw Abort(.notFound)
        }
        return momo
    }

    func update(req: Request) async throws -> Momo {
        guard let momoID = req.parameters.get("momoID", as: Int.self) else {
            throw Abort(.badRequest)
        }
        let updated = try req.content.decode(Momo.self)
        guard let momo = try await Momo.find(momoID, on: req.db) else {
            throw Abort(.notFound)
        }
        momo.name = updated.name
        momo.description = updated.description
        momo.image = updated.image
        momo.$autor.id = updated.$autor.id
        momo.$level.id = updated.$level.id
        try await momo.save(on: req.db)
        return momo
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let momoID = req.parameters.get("momoID", as: Int.self) else {
            throw Abort(.badRequest)
        }
        guard let momo = try await Momo.find(momoID, on: req.db) else {
            throw Abort(.notFound)
        }
        try await momo.delete(on: req.db)
        return .noContent
    }
}
