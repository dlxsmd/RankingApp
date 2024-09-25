//
//  File.swift
//  RankingApp
//
//  Created by Yuki Imai on 2024/09/26.
//

import Fluent
import Vapor

final class Player: Model, Content {
    static let schema = "players"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "score")
    var score: Int

    init() {}

    init(id: UUID? = nil, name: String, score: Int) {
        self.id = id
        self.name = name
        self.score = score
    }
}