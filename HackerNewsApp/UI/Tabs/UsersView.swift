//
//  UsersView.swift
//  HackerNewsApp
//
//  Created by Alex Semenikhine on 2022-10-08.
//

import SwiftUI

struct UsersView: View {
    
    @EnvironmentObject var viewModel: HNMainViewModel
    
    @State private var username: String = ""
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                Text("Hacker News")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, minHeight: 36, alignment: .leading)
            }
            .padding(.horizontal)
            .background(Color.gray.opacity(0.1))

            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(.gray.opacity(0.4))

            HStack {
                TextField("username", text: $username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                Button {
                    Task
                    {
                        let result = await viewModel.addUser(name: username)
                        if result == true
                        {
                            username = ""
                        }
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(username.count == 0 ? .gray : .black)
                }
                .disabled(username.count == 0)
                
            }.padding()
            
            ScrollView {
                VStack {
                    ForEach(viewModel.userIds, id: \.self) {
                        element in
                        HNUserCell(viewModel: HNRowViewModel<HNUser>(modelId: String(element), dataProvider: viewModel.dataProvider))
                    }
                }
            }
            
        }
        
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView().environmentObject(HNMainViewModel(dataProvider: HNDataProvider()))
    }
}
