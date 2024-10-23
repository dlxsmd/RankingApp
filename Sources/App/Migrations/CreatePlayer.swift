//
//  File.swift
//  RankingApp
//
//  Created by Yuki Imai on 2024/09/26.
//

import Fluent

struct CreatePlayer: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("players")
            .id()
            .field("name", .string, .required)
            .field("score", .int, .required)
            .field("createdAt", .string, .required)
            .field("email", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("players").delete()
    }
}
