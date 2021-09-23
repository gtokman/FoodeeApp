//
//  HomeViewModel.swift
//  Foodee
//
//  Created by Gary Tokman on 9/21/21.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var businesses = [Business]()
    @Published var searchText = ""
    
    func search() {
        let live = YelpApiService.live
        
        live.search("food", .init(latitude: 42.3601, longitude: -71.0589), nil)
            .assign(to: &$businesses)
    }
    
}
