//
//  Home.swift
//  RankingApp
//
//  Created by Yuki Imai on 2024/09/29.
//
import Foundation
import Ignite

struct Home: StaticPage {
    var title = "RyoDeveloper"

    func body(context: PublishingContext) -> [BlockElement] {
        Text("Hello, world!")
            .font(.title1)
    }
}
