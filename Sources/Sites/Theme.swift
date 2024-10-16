//
//  Theme.swift
//  RankingApp
//
//  Created by Yuki Imai on 2024/09/29.
//

import Foundation
import Ignite

struct MyTheme: Theme {
    func render(page: Page, context: PublishingContext) -> HTML {
        HTML {
            Head(for: page, in: context)

            Body {
                page.body
            }
        }
    }
}
