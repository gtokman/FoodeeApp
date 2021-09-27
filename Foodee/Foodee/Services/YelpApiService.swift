//
//  YelpApiService.swift
//  Foodee
//
//  Created by Gary Tokman on 9/21/21.
//

import Combine
import CoreLocation
import Foundation

let apiKey = ""

struct YelpApiService {
    // search term, user location, category      // output to update list
    var request: (Endpoint) -> AnyPublisher<[Business], Never>
    var details: (Endpoint) -> AnyPublisher<Business?, Never>
}

extension YelpApiService {
    static let live = YelpApiService(request: { endpoint in
        // URL request and return [Businesses]
        return URLSession.shared.dataTaskPublisher(for: endpoint.request)
            .map(\.data)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .map(\.businesses)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }, details: { endpoint in
        // URL request and return Businesses
        return URLSession.shared.dataTaskPublisher(for: endpoint.request)
            .map(\.data)
            .decode(type: Business?.self, decoder: JSONDecoder())
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    })
}

enum Endpoint {
    case search(term: String?, location: CLLocation, category: FoodCategory?)
    case detail(id: String)

    var path: String {
        switch self {
        case .search:
            return "/v3/businesses/search"
        case .detail(let id):
            return "/v3/businesses/\(id)"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let term, let location, let category):
            return [
                .init(name: "term", value: term),
                .init(name: "longitude", value: String(location.coordinate.longitude)),
                .init(name: "latitude", value: String(location.coordinate.latitude)),
                .init(name: "categories", value: category?.rawValue ?? FoodCategory.all.rawValue),
            ]
        case .detail:
            return []
        }
    }
    
    var request: URLRequest {
        var urlComponents = URLComponents(string: "https://api.yelp.com")!
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        return request
    }

}

// MARK: - SearchResult

struct SearchResult: Codable {
    let businesses: [Business]
}

// MARK: - Business
struct Business: Codable {
    let id, alias, name: String?
    let imageURL: String?
    let isClaimed, isClosed: Bool?
    let url: String?
    let phone, displayPhone: String?
    let reviewCount: Int?
    let categories: [Category]?
    let rating: Double?
    let location: Location?
    let coordinates: Coordinates?
    let photos: [String]?
    let price: String?
    let hours: [Hour]?
    let transactions: [String]?
    let specialHours: [SpecialHour]?

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClaimed = "is_claimed"
        case isClosed = "is_closed"
        case url, phone
        case displayPhone = "display_phone"
        case reviewCount = "review_count"
        case categories, rating, location, coordinates, photos, price, hours, transactions
        case specialHours = "special_hours"
    }
}

// MARK: - Category
struct Category: Codable {
    let alias, title: String?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double?
}

// MARK: - Hour
struct Hour: Codable {
    let hourOpen: [Open]?
    let hoursType: String?
    let isOpenNow: Bool?

    enum CodingKeys: String, CodingKey {
        case hourOpen = "open"
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
    }
}

// MARK: - Open
struct Open: Codable {
    let isOvernight: Bool?
    let start, end: String?
    let day: Int?

    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start, end, day
    }
}

// MARK: - Location
struct Location: Codable {
    let address1, address2, address3, city: String?
    let zipCode, country, state: String?
    let displayAddress: [String]?
    let crossStreets: String?

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
        case crossStreets = "cross_streets"
    }
}

// MARK: - SpecialHour
struct SpecialHour: Codable {
    let date: String?
    let isClosed: Bool?
    let start, end: String?
    let isOvernight: Bool?

    enum CodingKeys: String, CodingKey {
        case date
        case isClosed = "is_closed"
        case start, end
        case isOvernight = "is_overnight"
    }
}

extension Business {
    var formattedRating: String {
        String(format: "%.1f", rating ?? 0.0)
    }

    var formattedCategory: String {
        categories?.first?.title ?? "none"
    }

    var formattedName: String {
        name ?? "none"
    }
            
    var formattedPhoneNumber: String {
        displayPhone ?? "none"
    }
    
    var formattedPrice: String {
        price ?? "none"
    }
    
    var formattedAddress: String {
        location?.displayAddress?.first ?? "none"
    }
    
    var images: [URL] {
        return photos?.compactMap { URL.init(string: $0) } ?? []
    }

    var formattedImageUrl: URL? {
        if let imageUrl = imageURL {
            return URL(string: imageUrl)
        }
        return nil
    }
}
