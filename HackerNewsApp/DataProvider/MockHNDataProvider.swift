//
//  MockHNDataProvider.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import Foundation

class MockHNDataProvider: HNDataProviderInterface
{
    func getExistingItem<I>(id: String) -> I? where I : HNModel
    {
        switch I.self
        {
        case is HNItem.Type:
            return (story as! I)
            
        case is HNUser.Type:
            return (user as! I)
            
        default: fatalError()
        }
    }
    

    @Published var story: HNItem = HNItem(item_id: 123, author: "alex", created_at: Date(), title: "test_item", url: "http://google.com")
    @Published var user: HNUser = HNUser(item_id: "TheOtherHobbes", created_at: Date(), karma: 1)
    
    func loadNewStoryIds() async throws -> [Int] {
        return [1,2]

    }
    
    func loadTopStoryIds() async throws -> [Int] {
        return [1,2]
    }
    
    func getItem<I>(id: String) async throws -> I where I : HNModel
    {
        switch I.self
        {
        case is HNItem.Type:
            return story as! I
            
        case is HNUser.Type:
            return user as! I
            
        default: fatalError()
        }
    }
    
}
