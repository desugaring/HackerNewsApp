//
//  HNItemTests.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import XCTest
@testable import HackerNewsApp

class HNItemTests: XCTestCase {

    private let exampleHnItem = """
    {
      "by" : "dhouston",
      "descendants" : 71,
      "id" : 8863,
      "kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
      "score" : 111,
      "time" : 1175714200,
      "title" : "My YC app: Dropbox - Throw away your USB drive",
      "type" : "story",
      "url" : "http://www.getdropbox.com/u/2/screencast.html"
    }
    """
    
    /**
        Tests parsing of HNItem struct from a sample json using JSONDecoder
     */
    func testHNItemParsing() throws {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        
        let hnItemData = exampleHnItem.data(using: .utf8)!
        
        let decodedItem = try decoder.decode(HNItem.self, from: hnItemData)
        
        /*
         attributes to test:
         
         let id: Int
         let author: String?
         let created_at: Date?
         let title: String?
         let is_dead: Bool = false
         let url: String?
         */
        
        XCTAssert(decodedItem.item_id == 8863)
        XCTAssert(decodedItem.author == "dhouston")
        XCTAssert(decodedItem.created_at != nil)
        XCTAssert(decodedItem.title == "My YC app: Dropbox - Throw away your USB drive")
        XCTAssert(decodedItem.is_dead == false)
        XCTAssert(decodedItem.url == "http://www.getdropbox.com/u/2/screencast.html")
    }

}
