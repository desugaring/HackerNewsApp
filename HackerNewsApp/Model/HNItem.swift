//
//  HNItem.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import Foundation

protocol HNModel: Codable, Identifiable {}

struct HNItem: HNModel
{
    let id : UUID = UUID()
    let item_id: Int
    let author: String?
    let created_at: Date? // use decoder.dateDecodingStrategy = .millisecondsSince1970 to parse properly
    let title: String?
    let is_dead: Bool = false
    let url: String?
    var is_missing_item: Bool = false
    
    private enum CodingKeys: String, CodingKey
    {
        case item_id = "id"
        case author = "by"
        case created_at = "time"
        case title
        case is_dead = "dead"
        case url
    }
    
    static func testItem(title: String, id: Int) -> HNItem
    {
        let item = HNItem(item_id: id, author: "alex", created_at: Date(), title: title, url: "http://google.com")
        
        return item
    }
    
    static func missingItem() -> HNItem
    {
        var item = HNItem(item_id: 1, author: nil, created_at: nil, title: nil, url: nil)
        item.is_missing_item = true
        
        return item
    }
}


