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
    @Environment(\.managedObjectContext) var context

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Category
                Group {
                    Text(L10n.categories)
                        .font(.custom(.poppinsSemibold, size: 16))
                        .padding(.top, .small)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(FoodCategory.allCases, id: \.self) { category in
                                CategoryView(selectedCategory: $viewModel.selectedCategory, category: category)
                            }
                        }.padding(.small)
                    }
                }.padding(.leading, .large)

                // List
                List(viewModel.businesses, id: \.id) { business in
                    ZStack {
                        NavigationLink(destination: DetailView(id: business.id!)) {
                            EmptyView().opacity(0).frame(width: 0)
                        }
                        BusinessCell(business: business)
                            .padding(.bottom, .small)
                    }
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Save") {
                            // Save here
                            do {
                                try viewModel.save(business: business, with: context)
                                print("Saved")
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle(Text(viewModel.cityName))
                .searchable(text: $viewModel.searchText, prompt: Text(L10n.searchFood)) {
                    ForEach(viewModel.completions, id: \.self) { completion in
                        Text(completion).searchCompletion(completion)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { viewModel.showProfile.toggle() }) {
                            Image(systemName: "person")
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    Rectangle()
                        .fill(LinearGradient(colors: [.white, .white.opacity(0)], startPoint: .bottom, endPoint: .top))
                        .frame(height: 90)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .sheet(isPresented: $viewModel.showProfile) {
                ProfileView()
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
