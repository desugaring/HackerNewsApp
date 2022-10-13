//
//  HNMainViewModel.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import Foundation

/**
 
 Main View Model that drives UI for all 3 tabs - new stories, top stories, users

 - uses data provider to fetch data
 
 - has data:
    - top story ids
    - new story ids
    - user ids
 
 - has data statuses for:
    - new stories
    - top stories
 
 - has async methods to fetch
    - top story ids
    - new story ids
 
 - has add user method to add and user id, fetch user and store it in User Defaults for when we close and re-open the app
 
 */
@MainActor
class HNMainViewModel: ObservableObject
{
    @Published var newStoriesStatus: LoadableStatus = .loading
    @Published var topStoriesStatus: LoadableStatus = .loading
    @Published var topStoryIds: [Int] = []
    @Published var newStoryIds: [Int] = []
    @Published var userIds: [String]
        
    let dataProvider: HNDataProviderInterface
    
    init(dataProvider: HNDataProviderInterface)
    {
        self.dataProvider = dataProvider
        self.userIds = UserDefaults.standard.stringArray(forKey: "users") ?? []
    }
    
    func loadNewStoryIds() async
    {
        guard newStoryIds.count == 0 else { return }
        
        self.newStoriesStatus = .loading
        do
        {
            let ids = try await dataProvider.loadNewStoryIds()
            self.newStoryIds = ids
            self.newStoriesStatus = .loaded
        }
        catch
        {
            self.newStoriesStatus = .failed
        }
    }
    
    func loadTopStoryIds() async
    {
        guard topStoryIds.count == 0 else { return }
        
        topStoriesStatus = .loading
        do
        {
            let ids = try await dataProvider.loadTopStoryIds()
            self.topStoryIds = ids
            self.topStoriesStatus = .loaded
        }
        catch
        {
                self.topStoriesStatus = .failed
        }
    }
    
    func addUser(name: String) async -> Bool
    {
        guard userIds.contains(where: { $0 == name }) == false else { return false }
        
        do
        {
            let _: HNUser = try await dataProvider.getItem(id: name)
            self.userIds.append(name)
            UserDefaults.standard.set(self.userIds, forKey: "users")
            return true
        }
        catch
        {
            return false
        }
        
    }
    
}
