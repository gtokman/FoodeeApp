//
//  DetailView.swift
//  Foodee
//
//  Created by Gary Tokman on 9/26/21.
//

import MapKit
import SwiftUI

@available(iOS 15.0, *)
struct DetailView: View {
    let id: String
    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        ZStack(alignment: .top) {
            // Spacer
            Rectangle()
                .fill(Color.clear)

            // Map
            Map(coordinateRegion: $viewModel.region)
                .frame(height: UIScreen.main.bounds.height * 0.45)

        }.overlay(
            // Card
            viewModel.business != nil ? DetailCard(business: viewModel.business!) : nil,
            alignment: .bottom
        )
        .ignoresSafeArea(edges: [.top, .bottom])
        .onAppear {
            viewModel.requestDetails(forId: id)
        }
    }
}

@available(iOS 15.0, *)
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: "WavvLdfdP6g8aZTtbBQHTw")
            .environmentObject(HomeViewModel())
    }
}
