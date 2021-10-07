//
//  FoodeeApp.swift
//  Foodee
//
//  Created by Gary Tokman on 9/21/21.
//

import SwiftUI

@available(iOS 15.0, *)
@main
struct FoodeeApp: App {
    let viewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, viewModel.container.viewContext)
        }
    }
}
