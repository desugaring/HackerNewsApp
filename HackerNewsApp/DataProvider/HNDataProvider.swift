//
//  HNDataProvider.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import Foundation



class HNDataProvider: BaseJsonDataProvider, HNDataProviderInterface
{
    @Published var stories: [HNItem] = []
    @Published var users: [HNUser] = []
    
    func getExistingItem<M>(id: String) -> M? where M : HNModel
    {
        switch M.self
        {
        case is HNItem.Type:
            if let existingStory = stories.first(where: { String($0.item_id) == id })
            {
                // for debugging
//                print("existing")
                return existingStory as? M
            }
            
        case is HNUser.Type:
            if let existingUser = users.first(where: { $0.item_id == id })
            {
                return existingUser as? M
            }

        default: fatalError()
        }
        
        return nil
    }
    
    func getItem<M>(id: String) async throws -> M where M : HNModel
    {
        let url: URL
        
        switch M.self
        {
        case is HNItem.Type:

            url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty")!
            
        case is HNUser.Type:

            url = URL(string: "https://hacker-news.firebaseio.com/v0/user/\(id).json?print=pretty")!
            
        default: fatalError()
        }
        
        let result: M = try await fetchData(url: url)
        
        // for debugging
//        Thread.sleep(foraTimeInterval: 0.3)
        
        // cache result
        switch M.self
        {
        case is HNItem.Type:
            DispatchQueue.main.async {
                self.stories.append(result as! HNItem)
            }
            
        case is HNUser.Type:
            DispatchQueue.main.async {
                self.users.append(result as! HNUser)
            }
        default: fatalError()
        }
        
        return result
    }
    
    func loadNewStoryIds() async throws -> [Int]
    {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty")!
        
        return try await fetchData(url: url)
    }
    
    func loadTopStoryIds() async throws -> [Int]
    {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty")!
        
        return try await fetchData(url: url)
    }
    
}


