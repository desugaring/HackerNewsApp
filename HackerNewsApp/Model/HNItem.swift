//
//  HNItem.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import Foundation

/**
 
 HNModel is an empty protocol used to be able to pass HNUser or HNItem to a cell view model (HNRowViewModel)
 
 HNItem is the model for a HackerNews Story that get displayed in New Stories and Top Stories tabs of the app
 
 */
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
    
}


