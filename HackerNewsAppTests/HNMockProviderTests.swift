//
//  HNMockProviderTests.swift
//  HackerNewsAppTests
//
//  Created by Alex Semenikhine on 2022-10-13.
//

import XCTest
@testable import HackerNewsApp

class HNMockDataProviderTests: XCTestCase {

    /**
        Tests HNMockDataProvider's loadNewStoryIds() and getItem(id: String) methods for ability to successfully fetch new story ids and fetch first story item and parse it into HNItem
     */
    func testHNMockDataProviderNewStories() async throws {
        
        let dataProvider = HNMockDataProvider()
        
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
        Tests HNMockDataProvider's loadTopStoryIds() and getItem(id: String) methods for ability to successfully fetch top story ids and fetch first story item and parse it into HNItem
     */
    func testHNMockDataProviderTopStories() async throws {
        
        let dataProvider = HNMockDataProvider()
        
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
        Tests HNMockDataProvider's getItem(id: String) methods for ability to successfully fetch and parse an HNUser
     */
    func testHNMockDataProviderUser() async throws {
        
        let dataProvider = HNMockDataProvider()
        
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
