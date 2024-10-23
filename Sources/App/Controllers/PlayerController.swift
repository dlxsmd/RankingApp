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
        let today = Date()
        return Player.query(on: req.db)
            .filter(\.$createdAt, .greaterThan, today)
            .sort(\.$score, .descending)
            .limit(3)
            .all()
    }
    
    //すべてのプレイヤーのスコアを表示する
    func getAll(req: Request) throws -> EventLoopFuture<[Player]> {
        return Player.query(on: req.db)
            .sort(\.$score,.descending)
            .all()
    }
}
