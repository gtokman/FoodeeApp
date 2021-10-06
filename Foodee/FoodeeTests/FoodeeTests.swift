//
//  FoodeeTests.swift
//  FoodeeTests
//
//  Created by Gary Tokman on 10/5/21.
//

import Combine
import CombineExpectations
import XCTest

@testable import Foodee

class FoodeeTests: XCTestCase {

    func testHomeViewModelRequestAssignsBussinesses() throws {
        // Given
        let viewModel = HomeViewModel()
        let testService = YelpApiService { _ in
            Just([
                Business(
                    id: "1",
                    alias: nil,
                    name: nil,
                    imageURL: nil,
                    isClaimed: nil,
                    isClosed: nil,
                    url: nil,
                    phone: nil,
                    displayPhone: nil,
                    reviewCount: nil,
                    categories: nil,
                    rating: nil,
                    location: nil,
                    coordinates: nil,
                    photos: nil,
                    price: nil,
                    hours: nil,
                    transactions: nil,
                    specialHours: nil
                )
            ]).eraseToAnyPublisher()
        } details: { _ in
            Empty().eraseToAnyPublisher()
        } completion: { _ in
            Empty().eraseToAnyPublisher()
        }
        let recorder = viewModel.$businesses.record()

        // When
        viewModel.request(service: testService)
        // When the user starts typing
        viewModel.searchText = "whole foods"

        // Then
        let businesses = try wait(for: recorder.availableElements, timeout: 0.3)
            .reduce([], +)
        print("value", businesses)

        XCTAssertEqual(businesses.count, 1)
        XCTAssertEqual(businesses.first?.id, "1")
    }

    func testHomeViewModelRequestDetailsAssignsToBusiness() throws {
        // Given
        let viewModel = HomeViewModel()
        let testService = YelpApiService { _ in
            Empty().eraseToAnyPublisher()
        } details: { _ in
            Just(
                Business(
                    id: "1",
                    alias: nil,
                    name: nil,
                    imageURL: nil,
                    isClaimed: nil,
                    isClosed: nil,
                    url: nil,
                    phone: nil,
                    displayPhone: nil,
                    reviewCount: nil,
                    categories: nil,
                    rating: nil,
                    location: nil,
                    coordinates: nil,
                    photos: nil,
                    price: nil,
                    hours: nil,
                    transactions: nil,
                    specialHours: nil
                )
            ).eraseToAnyPublisher()
        } completion: { _ in
            Empty().eraseToAnyPublisher()
        }
        
        // When
        viewModel.requestDetails(forId: "", service: testService)
        let recorder = viewModel.$business.prefix(1).record()
        
        // Then
        let business = try wait(for: recorder.single, timeout: 0.3)
//        print("business", business)
        XCTAssertNotNil(business)
        XCTAssertEqual(business?.id, "1")
    }
}
