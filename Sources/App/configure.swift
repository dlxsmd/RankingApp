import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // Postgresデータベースの設定
    
    if let databaseURL = Environment.get("DATABASE_URL") {
            try app.databases.use(.postgres(url: databaseURL), as: .psql)
        } else {
            // フォールバック設定またはローカル開発用設定
            app.databases.use(.postgres(
                hostname: Environment.get("DB_HOST") ?? "localhost",
                port: Environment.get("DB_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
                username: Environment.get("DB_USER") ?? "vapor",
                password: Environment.get("DB_PASSWORD") ?? "password",
                database: Environment.get("DB_NAME") ?? "vapor"
            ), as: .psql)
        }
    
    app.migrations.add(CreatePlayer())
    try app.autoMigrate().wait()
    try routes(app)

}
