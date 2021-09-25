//
//  HomeViewModel.swift
//  Foodee
//
//  Created by Gary Tokman on 9/21/21.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {

    @Published var businesses = [Business]()
    @Published var searchText: String
    @Published var selectedCategory: FoodCategory
    
    init() {
        searchText = ""
        selectedCategory = .all
        
        request()
    }

    func request(service: YelpApiService = .live) {
        $searchText
            .combineLatest($selectedCategory)
            .flatMap { (term, category) in
                service.request(
                    .search(
                        term: term,
                        location: .init(latitude: 42.3601, longitude: -71.0589),
                        category: term.isEmpty ? category : nil
                    )
                )
            }
            .assign(to: &$businesses)
    }

}
