//
//  HomeView.swift
//  Foodee
//
//  Created by Gary Tokman on 9/21/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.businesses, id: \.id) { business in
                    Text(business.name ?? "no name")
                }
            }
            .listStyle(.plain)
            .navigationTitle(Text("Boston"))
            .searchable(text: $viewModel.searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "person")
                }
            }
            .onAppear(perform: viewModel.search)

        }
    }
}

@available(iOS 15.0, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
