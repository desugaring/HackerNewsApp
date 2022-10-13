//
//  HNRowViewModel.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import Foundation

/**
 
 Row View Model that drives UI for list cells in all 3 tabs - new stories, top stories, users

 - uses data provider to fetch data
 
 - has data:
    - model id (to be able to fetch model)
    - data provider (to be able to fetch model)
    - model (story or user)
    - status (loading, loaded or failed)
 
 - has load method for:
        - loading model using data provider and modelId
        - first checks for existing model inside dataProvider
            - if not present, async fetches using data provider
            - updates status attribute, used in cell view to update UI
  
 */
@MainActor
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

                    self.model = model
                    self.status = .loaded
                }
                catch
                {
                    self.status = .failed
                }
            }
        }
    }
}
