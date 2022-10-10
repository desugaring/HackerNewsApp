//
//  TopStoriesView.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-09.
//

import SwiftUI

struct TopStoriesView: View {
    
    @EnvironmentObject var viewModel: HNMainViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                Text("Hacker News")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, minHeight: 36, alignment: .leading)
                if viewModel.topStoriesStatus == .loaded
                {
                    Button {
                        viewModel.topStoriesStatus = .loading
                        viewModel.topStoryIds = []
                        Task
                        {
                            await viewModel.loadTopStoryIds()
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

            
            switch viewModel.topStoriesStatus
            {
            case .loading:
                
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .task {
                        await viewModel.loadTopStoryIds()
                    }
                
            case .loaded:
                
                ScrollView {
                    Spacer(minLength: 10)
                    LazyVStack {
                        ForEach(viewModel.topStoryIds, id: \.self) {
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

struct TopStoriesView_Previews: PreviewProvider {
    static var previews: some View {
        TopStoriesView().environmentObject(HNMainViewModel(dataProvider: HNDataProvider()))
    }
}
