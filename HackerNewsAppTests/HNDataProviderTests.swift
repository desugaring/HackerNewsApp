//
//  HNDataProviderTests.swift
//  HackerNewsAppTests
//
//  Created by Alex Semenikhine on 2022-10-09.
//

import XCTest
@testable import HackerNewsApp

class HNDataProviderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHNDataProviderNewStories() async throws {
        
        let dataProvider = HNDataProvider()
        
        // fetch new story ids
        let storyIds = try await dataProvider.loadNewStoryIds()
            
        // fetch first story
        if let firstStoryId = storyIds.first
        {
            let _: HNItem = try await dataProvider.getItem(id: String(firstStoryId))
        }
        
    }
    
    func testHNDataProviderTopStories() async throws {
        
        let dataProvider = HNDataProvider()
        
        // fetch top story ids
        let storyIds = try await dataProvider.loadTopStoryIds()
            
        // fetch first story
        if let firstStoryId = storyIds.first
        {
            let _: HNItem = try await dataProvider.getItem(id: String(firstStoryId))
        }
        
    }
    
    func testHNDataProviderUser() async throws {
        
        let dataProvider = HNDataProvider()
        
        // fetch user
        let _: HNUser = try await dataProvider.getItem(id: "TheOtherHobbes") // a longtime HackerNews user, if he ever disappears, replace this username with another
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
