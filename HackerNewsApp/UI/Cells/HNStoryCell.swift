//
//  HNStoryCell.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import SwiftUI

/**
 
 Story list cell view with

 - a loading spinner in loading state
 - error message in case of an error
 - story title, url and author once the story has loaded
 
 - clicking on this cell when loaded navigates to a webview page with the story displayed
 
 */
struct HNStoryCell: View {
    
    @ObservedObject var viewModel: HNRowViewModel<HNItem>
    @Environment(\.openURL) var openURL
    
    @State var loadingOpacity: Double = 0
    @State var itemOpacity: Double = 0
    
    init(viewModel: HNRowViewModel<HNItem>)
    {
        self.viewModel = viewModel
    }
    
    var body: some View {

        VStack() {
            
            switch self.viewModel.status
            {
            case .failed:
                
                Text("Oops, something went wrong").font(.caption)
                
            case .loading:
                
                ProgressView().progressViewStyle(.circular)
                    .opacity(loadingOpacity)
                    .onAppear {
                        let anim = Animation.easeIn(duration: 0.3)
                        withAnimation(anim) {
                            loadingOpacity = 1
                        }
                    }
            case .loaded:
                
                Group {
                    Text(viewModel.model!.title ?? "Missing Title")
                        .multilineTextAlignment(.leading)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    Text(viewModel.model!.url ?? "missing url")
                        .foregroundColor(Color.secondary)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    Text(viewModel.model!.author ?? "Missing Author")
                        .foregroundColor(Color.black)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .opacity(itemOpacity)
                .onAppear {
                    let anim = Animation.easeIn(duration: 0.3)
                    withAnimation(anim) {
                        itemOpacity = 1
                    }
                }
                .onTapGesture {
                    if let urlStr = viewModel.model?.url,
                        let url = URL(string: urlStr)
                    {
                        openURL(url)
                    
                    }
                }
            
            }

        }
        .padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))

    }
}

struct HNStoryCell_Previews: PreviewProvider {
    static var previews: some View {
        HNStoryCell(viewModel: HNRowViewModel(modelId: "1", dataProvider: MockHNDataProvider()))
    }
}
