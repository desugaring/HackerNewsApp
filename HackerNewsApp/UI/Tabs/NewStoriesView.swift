//
//  NewStoriesView.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-09.
//

import SwiftUI

/**
 
 New stories view with
 - a loading spinner in loading state
 - error message in case of an error
 - a list of new HackerNews stories in once they've loaded
 
 - clicking on a story navigates to a webview page with the clicked on story displayed
 
 */
struct NewStoriesView: View {
    
    @EnvironmentObject var viewModel: HNMainViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                Text("Hacker News")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, minHeight: 36, alignment: .leading)
                if viewModel.newStoriesStatus == .loaded
                {
                    Button {
                        viewModel.newStoriesStatus = .loading
                        viewModel.newStoryIds = []
                        Task
                        {
                            await viewModel.loadNewStoryIds()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise").foregroundColor(.black)
                    }
                }
                    
            }
            .padding(.horizontal)
            .background(Color.gray.opacity(0.1))

            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(.gray.opacity(0.4))

            
            switch viewModel.newStoriesStatus
            {
            case .loading:
                
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .task {
                        await viewModel.loadNewStoryIds()
                    }
                
            case .loaded:
                
                ScrollView {
                    Spacer(minLength: 10)
                    LazyVStack {
                        ForEach(viewModel.newStoryIds, id: \.self) {
                            element in
                            HNStoryCell(viewModel: HNRowViewModel<HNItem>(modelId: String(element), dataProvider: viewModel.dataProvider))
                        }
                    }
                }
                
            case .failed:
                
                Text("Oops, something went wrong")
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            
        }

    }
}

struct NewStoriesView_Previews: PreviewProvider {
    static var previews: some View {
        NewStoriesView().environmentObject(HNMainViewModel(dataProvider: HNDataProvider()))
    }
}
