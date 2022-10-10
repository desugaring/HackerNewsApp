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
        let (data, response) = try await session.data(from: url)
        
        if let res = response as? HTTPURLResponse
        {
            print(res.statusCode)
        }
        
        let item = try jsonDecoder.decode(T.self, from: data)
        
        return item
    }
}
