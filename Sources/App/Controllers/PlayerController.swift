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
        players.get("top", use: getTop)
    }

    // プレイヤーを作成するエンドポイント
    func create(req: Request) throws -> EventLoopFuture<Player> {
        let player = try req.content.decode(Player.self)
        return player.save(on: req.db).map { player }
    }

    // トップスコアのプレイヤーを取得するエンドポイント
    func getTop(req: Request) throws -> EventLoopFuture<[Player]> {
        return Player.query(on: req.db)
            .sort(\.$score, .descending)
            .limit(10)
            .all()
    }
}
