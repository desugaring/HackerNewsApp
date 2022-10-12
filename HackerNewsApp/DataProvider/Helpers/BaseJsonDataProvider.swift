//
//  BaseJsonDataProvider.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-09.
//

import Foundation

class BaseJsonDataProvider
{
    let session = URLSession.shared
    let jsonDecoder = JSONDecoder()
    
    init()
    {
        jsonDecoder.dateDecodingStrategy = .millisecondsSince1970
    }
    
    func fetchData<T: Codable>(url: URL) async throws -> T
    {
        let (data, _) = try await session.data(from: url)
        
        let item = try jsonDecoder.decode(T.self, from: data)
        
        return item
    }
}
