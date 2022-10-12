//
//  HNDataProviderTests.swift
//  HackerNewsAppTests
//
//  Created by Alex Semenikhine on 2022-10-09.
//

import XCTest
@testable import HackerNewsApp

class HNDataProviderTests: XCTestCase {

    /**
        Tests HNDataProvider's loadNewStoryIds() and getItem(id: String) methods for ability to successfully fetch new story ids and fetch first story item and parse it into HNItem
     */
    func testHNDataProviderNewStories() async throws {
        
        let dataProvider = HNDataProvider()
        
        var storyIds: [Int] = []
        
        do
        {
            // fetch top story ids
            storyIds = try await dataProvider.loadNewStoryIds()
        }
        catch
        {
            XCTFail("failed to get new story ids")
        }
        
        do
        {
            // fetch first story
            if let firstStoryId = storyIds.first
            {
                let _: HNItem = try await dataProvider.getItem(id: String(firstStoryId))
            }
        }
        catch
        {
            XCTFail("failed to get first new story item")
        }
        
    }
    
    /**
        Tests HNDataProvider's loadTopStoryIds() and getItem(id: String) methods for ability to successfully fetch top story ids and fetch first story item and parse it into HNItem
     */
    func testHNDataProviderTopStories() async throws {
        
        let dataProvider = HNDataProvider()
        
        var storyIds: [Int] = []
        
        do
        {
            // fetch top story ids
            let storyIds = try await dataProvider.loadTopStoryIds()
            
            // fetch first story
            if let firstStoryId = storyIds.first
            {
                let _: HNItem = try await dataProvider.getItem(id: String(firstStoryId))
            }
        }
        catch
        {
            XCTFail("failed to get top story ids")
        }
        
        do
        {
            // fetch first story
            if let firstStoryId = storyIds.first
            {
                let _: HNItem = try await dataProvider.getItem(id: String(firstStoryId))
            }
        }
        catch
        {
            XCTFail("failed to get first new story item")
        }
        
    }
    
    /**
        Tests HNDataProvider's getItem(id: String) methods for ability to successfully fetch and parse an HNUser
     */
    func testHNDataProviderUser() async throws {
        
        let dataProvider = HNDataProvider()
        
        do
        {
            // fetch user
            let _: HNUser = try await dataProvider.getItem(id: "TheOtherHobbes") // a longtime HackerNews user, if he ever disappears, replace this username with another
        }
        catch
        {
            XCTFail("failed to get user named TheOtherHobbes")
        }
        
    }

}
