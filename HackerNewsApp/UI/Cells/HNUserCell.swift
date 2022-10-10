//
//  HNUserCell.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-06.
//

import SwiftUI

struct HNUserCell: View {
    
    @ObservedObject var viewModel: HNRowViewModel<HNUser>
    @Environment(\.openURL) var openURL
    
    @State var loadingOpacity: Double = 0
    @State var itemOpacity: Double = 0
    
    init(viewModel: HNRowViewModel<HNUser>)
    {
        self.viewModel = viewModel
    }
    
    var body: some View {

        VStack() {
            
            switch self.viewModel.status
            {
            case .failed:
                
                Text("Oops, something went wrong").font(.caption).foregroundColor(.gray)
                
            case .loaded:
                
                Group {
                    Text(viewModel.model!.item_id)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                    Text("\( viewModel.model!.karma) karma")
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
                    if let url = URL(string: "https://news.ycombinator.com/user?id=\(viewModel.model!.item_id)")
                    {
                        openURL(url)
                    }
                }
                
            case .loading:
                
                ProgressView().progressViewStyle(.circular)
                    .opacity(loadingOpacity)
                    .onAppear {
                        let anim = Animation.easeIn(duration: 0.3)
                        withAnimation(anim) {
                            loadingOpacity = 1
                        }
                    }
            }

        }
        .padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))

    }
}

struct HNUserCell_Previews: PreviewProvider {
    static var previews: some View {
        HNUserCell(viewModel: HNRowViewModel(modelId: "TheOtherHobbes", dataProvider: MockHNDataProvider()))
    }
}
