import Fluent
import Vapor

// Struct para representar la vista
struct MomoView: Content {
    var MomoID: Int
    var Name: String
    var Description: String
    var Image: String
    var Autor: String
    var Autor_Description: String
    var Level: Int
    var Level_Image: String
}

// Struct simple para filtros
struct MomoSimple: Content {
    var Name: String
    var Description: String
    var Image: String
}

struct MomoController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let momos = routes.grouped("momos")
        momos.get(use: index)  //vista vw_Momo
        momos.post(use: create)

        momos.group(":momoID") { momo in
            momo.get(use: show) //sp_GetMomo
            momo.put(use: update)
            momo.delete(use: delete)
        }

        momos.get("level", ":levelNumber", use: filterByLevel)
        momos.get("autor", ":autorName", use: filterByAutor)
    }

    //  SELECT * FROM vw_Momo
    func index(req: Request) async throws -> [MomoView] {
        try await req.db.raw("SELECT * FROM vw_Momo").all(decoding: MomoView.self)
    }

    // CALL sp_GetMomo(?)
    func show(req: Request) async throws -> MomoView {
        guard let momoID = req.parameters.get("momoID", as: Int.self) else {
            throw Abort(.badRequest, reason: "ID inválido")
        }

        let query = "CALL sp_GetMomo(?)"
        return try await req.db.raw(SQLQueryString(query))
            .bind(momoID)
            .first(decoding: MomoView.self)
            .unwrap(or: Abort(.notFound))
    }

    
    func filterByLevel(req: Request) async throws -> [MomoSimple] {
        guard let level = req.parameters.get("levelNumber", as: Int.self) else {
            throw Abort(.badRequest, reason: "Nivel inválido")
        }

        let query = "CALL sp_FilterByLevel(?)"
        return try await req.db.raw(SQLQueryString(query))
            .bind(level)
            .all(decoding: MomoSimple.self)
    }

    func filterByAutor(req: Request) async throws -> [MomoSimple] {
        guard let autor = req.parameters.get("autorName") else {
            throw Abort(.badRequest, reason: "Nombre de autor inválido")
        }

        let query = "CALL sp_FilterByAutor(?)"
        return try await req.db.raw(SQLQueryString(query))
            .bind(autor)
            .all(decoding: MomoSimple.self)
    }

    
    func create(req: Request) async throws -> Momo {
        let momo = try req.content.decode(Momo.self)
        try await momo.save(on: req.db)
        return momo
    }

    func update(req: Request) async throws -> Momo {
        guard let momoID = req.parameters.get("momoID", as: Int.self),
              let momo = try await Momo.find(momoID, on: req.db) else {
            throw Abort(.notFound)
        }

        let updated = try req.content.decode(Momo.self)
        momo.name = updated.name
        momo.description = updated.description
        momo.image = updated.image
        momo.$autor.id = updated.$autor.id
        momo.$level.id = updated.$level.id

        try await momo.save(on: req.db)
        return momo
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let momoID = req.parameters.get("momoID", as: Int.self),
              let momo = try await Momo.find(momoID, on: req.db) else {
            throw Abort(.notFound)
        }

        try await momo.delete(on: req.db)
        return .noContent
    }
}

