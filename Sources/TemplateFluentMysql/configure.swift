import NIOSSL
import Fluent
import FluentMySQLDriver
import Vapor

public func configure(_ app: Application) async throws {
    // Configura la base de datos MySQL con credenciales personalizadas
    app.databases.use(
    .mysql(
        hostname: "db",  // ← Nombre real del contenedor MySQL
        port: 3306,                     // ← Puerto correcto expuesto por el contenedor
        username: "api-user",
        password: "Password1",
        database: "blackies",
        tlsConfiguration: .forClient(certificateVerification: .none)
    ),
    as: .mysql
)


    // Middleware estático opcional
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Agrega aquí tus migraciones si ya las tienes
    // app.migrations.add(CreateSomething())

    // Carga rutas
    try routes(app)
}

