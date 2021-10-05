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
    @Published var showModal: Bool
    @Published var cityName = ""
    @Published var completions = [String]()
    
    let manager = CLLocationManager()

    init() {
        searchText = ""
        selectedCategory = .all
        region = .init()
        business = nil
        showModal = manager.authorizationStatus == .notDetermined
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        request()
    }
    
    func requestPermission() {
        manager
            .requestLocationWhenInUseAuthorization()
            .map { $0 == .notDetermined }
            .assign(to: &$showModal)
    }
    
    func getLocation() -> AnyPublisher<CLLocation, Never> {
        manager.receiveLocationUpdates(oneTime: true)
            .replaceError(with: [])
            .compactMap(\.first)
            .eraseToAnyPublisher()
    }

    func request(service: YelpApiService = .live) {
        let location = getLocation().share()
        
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .combineLatest($showModal, $selectedCategory, location)
            .print()
            .flatMap { (term, show, category, location) in
                service.request(
                    .search(
                        term: term,
                        location: location,
                        category: term.isEmpty ? category : nil
                    )
                )
            }
            .assign(to: &$businesses)
        
        location
            .flatMap {
                $0.reverseGeocode()
            }
            .compactMap(\.first)
            .compactMap(\.locality)
            .replaceError(with: "")
            .assign(to: &$cityName)
        
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .combineLatest(location)
            .flatMap { term, location in
                service.completion(.completion(text: term, location: location))
            }
            .map { $0.map(\.text) }
            .assign(to: &$completions)
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
