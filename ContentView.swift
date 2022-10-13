//
//  ContentView.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import SwiftUI

/**
 
 Main app view that has 3 tabs
    - New Stories
    - Top Stories
    - Users
 
 */
struct ContentView: View {
    
    @EnvironmentObject var viewModel: HNMainViewModel
        
    var body: some View {
        
        TabView {

            NewStoriesView()
                .tabItem {
                    Label("New Stories", systemImage: "pencil.circle")
                    Text("New Stories")
                }
            TopStoriesView()
                .tabItem {
                    Label("Top Stories", systemImage: "star.circle")
                    Text("Top Stories")
                
                }
            UsersView()
                .tabItem {
                    Label("Users", systemImage: "person.circle")
                    Text("Users")
                }
        }
            
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(HNMainViewModel(dataProvider: HNDataProvider()))
    }
}
