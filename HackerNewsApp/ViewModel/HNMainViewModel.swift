//
//  HNMainViewModel.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import Foundation

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
        
        newStoriesStatus = .loading
        do
        {
            let ids = try await dataProvider.loadNewStoryIds()
            DispatchQueue.main.async {
                self.newStoryIds = ids
                self.newStoriesStatus = .loaded
            }
        }
        catch
        {
            DispatchQueue.main.async {
                self.newStoriesStatus = .failed
            }
        }
    }
    
    func loadTopStoryIds() async
    {
        guard topStoryIds.count == 0 else { return }
        
        topStoriesStatus = .loading
        do
        {
            let ids = try await dataProvider.loadTopStoryIds()
            DispatchQueue.main.async
            {
                self.topStoryIds = ids
                self.topStoriesStatus = .loaded
            }
        }
        catch
        {
            DispatchQueue.main.async
            {
                self.topStoriesStatus = .failed
            }
        }
    }
    
    func addUser(name: String) async -> Bool
    {
        guard userIds.contains(where: { $0 == name }) == false else { return false }
        
        do
        {
            let _: HNUser = try await dataProvider.getItem(id: name)
            DispatchQueue.main.async {
                self.userIds.append(name)
                UserDefaults.standard.set(self.userIds, forKey: "users")
            }
            return true
        }
        catch
        {
            print("username likely doesn't exist")
            return false
        }
        
    }
    
}
