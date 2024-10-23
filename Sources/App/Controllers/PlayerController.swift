//
//  File.swift
//  RankingApp
//
//  Created by Yuki Imai on 2024/09/26.
//

import Fluent
import Vapor

struct PlayerController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let players = routes.grouped("players")
        players.post(use: create)
        players.delete(use: delete)
        players.get("top", use: getTop)
        players.get("today", use: getToday)
        players.get("all",use: getAll)
    }

    // プレイヤーを作成するエンドポイント
    func create(req: Request) throws -> EventLoopFuture<Player> {
        let player = try req.content.decode(Player.self)
        return player.save(on: req.db).map { player }
    }
    
    // プレイヤーデータを削除するエントリーポイント
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Player.query(on: req.db)
            .delete()
            .transform(to: .noContent)
    }

    // トップスコアのプレイヤーを取得するエンドポイント
    func getTop(req: Request) throws -> EventLoopFuture<[Player]> {
        return Player.query(on: req.db)
            .sort(\.$score, .descending)
            .limit(10)
            .all()
    }
    
    func getToday(req: Request) throws -> EventLoopFuture<[Player]> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        
        // Calculate end of day by adding one day and subtracting a second
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)?.addingTimeInterval(-1) else {
            throw Abort(.internalServerError)
        }
        
        return Player.query(on: req.db)
            .filter(\.$createdAt >= startOfDay)
            .filter(\.$createdAt <= endOfDay)
            .sort(\.$score, .descending)
            .limit(1)
            .all()
    }
    
    //すべてのプレイヤーのスコアを表示する
    func getAll(req: Request) throws -> EventLoopFuture<[Player]> {
        return Player.query(on: req.db)
            .sort(\.$score,.descending)
            .all()
    }
}
