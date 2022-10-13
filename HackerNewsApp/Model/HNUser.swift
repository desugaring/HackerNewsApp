//
//  HNUser.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import Foundation

/**
 
 HNUser is the model for a HackerNews User that get displayed in Users tabs of the app
 
 */
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
    
}
