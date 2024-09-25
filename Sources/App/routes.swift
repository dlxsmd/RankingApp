import Fluent
import Vapor

func routes(_ app: Application) throws {
    let playerController = PlayerController()
    try app.register(collection: playerController)
}
