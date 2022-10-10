//
//  DataProviderInterfaces.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-09.
//

import Foundation

protocol HNSingleItemDataProviderInterface
{
    func getExistingItem<I: HNModel>(id: String) -> I?
    func getItem<I: HNModel>(id: String) async throws -> I
}

protocol HNDataProviderInterface: HNSingleItemDataProviderInterface
{
    func loadNewStoryIds() async throws -> [Int]
    func loadTopStoryIds() async throws -> [Int]
}
