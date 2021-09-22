//
//  Categories.swift
//  Foodee
//
//  Created by Gary Tokman on 9/22/21.
//

import Foundation

enum FoodCategory: String, CaseIterable, Equatable {
    case all, coffee, beer
    case icecream = "ice cream"
    case breakfeast, donuts

    var emoji: String {
        switch self {
        case .all:
            return "\u{1F959}"
        case .coffee:
            return "\u{2615}"
        case .beer:
            return "\u{1F37A}"
        case .icecream:
            return "\u{1F366}"
        case .breakfeast:
            return "\u{1F95E}"
        case .donuts:
            return "\u{1F369}"
        }
    }

    var alias: String {
        switch self {
        case .all:
            return "restaurants"
        case .coffee:
            return "coffee"
        case .beer:
            return "beer_and_wine"
        case .icecream:
            return "icecream"
        case .breakfeast:
            return "breakfast_brunch"
        case .donuts:
            return "donuts"
        }
    }
}
