//
//  HNUser.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import Foundation

struct HNUser: HNModel
{
    let id: UUID = UUID()
    let item_id: String
    let created_at: Date // // use decoder.dateDecodingStrategy = .millisecondsSince1970 to parse properly
    let karma: Int
    
    private enum CodingKeys: String, CodingKey
    {
        case item_id = "id"
        case created_at = "created"
        case karma
    }
    
    static func testUser(id: String) -> HNUser
    {
        let user = HNUser(item_id: id, created_at: Date(), karma: 1)
        
        return user
    }
}
