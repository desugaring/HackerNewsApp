//
//  HackerNewsAppApp.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import SwiftUI

/**
 
 SwiftUI App that uses official HackerNews API to showcase use of swiftui, async/await, generics, testing, lazy loading and clean design
 
 */
@main
struct HackerNewsAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(HNMainViewModel(dataProvider: HNDataProvider()))
        }
    }
}
