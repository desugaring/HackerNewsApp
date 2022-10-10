//
//  HNRowViewModel.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import Foundation

class HNRowViewModel<M: HNModel>: ObservableObject
{
    var model: M?
    var modelId: String = ""
    @Published var status: LoadableStatus = .loading
    var dataProvider: HNSingleItemDataProviderInterface
    
    init(modelId: String, dataProvider: HNSingleItemDataProviderInterface)
    {
        self.modelId = modelId
        self.dataProvider = dataProvider
        self.load()
    }
    
    func load()
    {
        // check cache
        if let existingItem: M = dataProvider.getExistingItem(id: modelId)
        {
            self.model = existingItem
            self.status = .loaded
        }
        else
        {
            self.status = .loading

            Task
            {
                do
                {
                    let model: M = try await dataProvider.getItem(id: modelId)
                    DispatchQueue.main.async
                    {
                        self.model = model
                        self.status = .loaded
                    }
                }
                catch
                {
                    DispatchQueue.main.async
                    {
                        self.status = .failed
                    }
                }
            }
        }
    }
}
