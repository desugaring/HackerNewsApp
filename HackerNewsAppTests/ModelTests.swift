//
//  ModelTest.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import XCTest
@testable import HackerNewsApp



class ModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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
    
    private let exampleHnUser = """
    {
      "about" : "This is a test",
      "created" : 1173923446,
      "delay" : 0,
      "id" : "jl",
      "karma" : 2937,
    }
    """
    
    func testHNUserParsing() throws {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        
        let hnUser = exampleHnUser.data(using: .utf8)!
        
        let decodedItem = try decoder.decode(HNUser.self, from: hnUser)
        
        /*
         attributes to test:
         
         let id: String
         let karma: Int
         */
        
        XCTAssert(decodedItem.item_id == "jl")
        XCTAssert(decodedItem.karma == 2937)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
