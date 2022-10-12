//
//  HNUserTests.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import XCTest
@testable import HackerNewsApp

class HNUserTests: XCTestCase {

    private let exampleHnUser = """
    {
      "about" : "This is a test",
      "created" : 1173923446,
      "delay" : 0,
      "id" : "jl",
      "karma" : 2937,
    }
    """
    
    /**
        Tests parsing of HNUser struct from a sample json using JSONDecoder
     */
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

}
