//
//  HomeView.swift
//  Foodee
//
//  Created by Gary Tokman on 9/21/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct HomeView: View {

    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Category
                Group {
                    Text("Categories")
                        .bold()
                        .padding(.leading, .large)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(FoodCategory.allCases, id: \.self) { category in
                                CategoryView(selectedCategory: $viewModel.selectedCategory, category: category)
                            }
                        }.padding(.small)
                    }
                }
                // List
                List(viewModel.businesses, id: \.id) { business in
                    NavigationLink(destination: DetailView(id: business.id!)) {
                        BusinessCell(business: business)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .navigationTitle(Text(viewModel.cityName))
                .searchable(text: $viewModel.searchText)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "person")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showModal, onDismiss: nil) {
                PermissionView {
                    viewModel.requestPermission()
                }
            }
            .onChange(of: viewModel.showModal) { newValue in
                viewModel.request()
            }
            
        }
    }
}

@available(iOS 15.0, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
