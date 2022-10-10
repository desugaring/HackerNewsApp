//
//  HackerNewsAppApp.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import SwiftUI

@main
struct HackerNewsAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(HNMainViewModel(dataProvider: HNDataProvider()))
        }
    }
}
