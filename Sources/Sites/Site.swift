//
//  Site.swift
//  RankingApp
//
//  Created by Yuki Imai on 2024/09/29.
//

import Foundation
import Ignite

@main
struct MyDeveloperSite {
    static func main() {
        let site = MySite()

        do {
            try site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct MySite: Site {
    var name = "RyoDeveloper"
    var url = URL("https://ryodeveloper.com") // Base URL
    var author = "RyoDeveloper"
    var language = Language.japanese

    var homePage = Home() // Root domainのPage
    var theme = MyTheme()

    var pages: [any StaticPage] {
        Home()
    }
}
