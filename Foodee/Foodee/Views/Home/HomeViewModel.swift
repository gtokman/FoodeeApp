//
//  HomeViewModel.swift
//  Foodee
//
//  Created by Gary Tokman on 9/21/21.
//

import Combine
import Foundation
import MapKit
import ExtensionKit
import CoreLocation

final class HomeViewModel: ObservableObject {

    @Published var businesses = [Business]()
    @Published var searchText: String
    @Published var selectedCategory: FoodCategory
    @Published var region: MKCoordinateRegion
    @Published var business: Business?

    init() {
        searchText = ""
        selectedCategory = .all
        region = .init()
        business = nil

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

    func requestDetails(forId id: String) {
        let live = YelpApiService.live

        let details =
            live
            .details(.detail(id: id))
            .share()

        details
            .compactMap { business in
                CLLocationCoordinate2D(
                    latitude: business?.coordinates?.latitude ?? 0,
                    longitude: business?.coordinates?.longitude ?? 0
                )
            }
            .compactMap { coor in
                MKCoordinateRegion(
                    center: coor,
                    span: .init(latitudeDelta: 0.001, longitudeDelta: 0.001)
                )
            }
            .assign(to: &$region)
        
        details
            .assign(to: &$business)
    }

}
