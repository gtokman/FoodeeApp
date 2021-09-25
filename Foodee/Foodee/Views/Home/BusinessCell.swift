//
//  BusinessCell.swift
//  Foodee
//
//  Created by Gary Tokman on 9/24/21.
//

import SwiftUI
import ExtensionKit

@available(iOS 15.0, *)
struct BusinessCell: View {
    let business: Business

    var body: some View {
        HStack {
            // Image
            AsyncImage(url: business.formattedImageUrl) { image in
                image.resizable()
            } placeholder: {
                Color.gray.shimmer()
            }
            .frame(width: 110, height: 110)
            .cornerRadius(10)
            .padding(.small)
            
            // Labels
            VStack(alignment: .leading, spacing: .small) {
                Text(business.formattedName)
                Text(business.formattedCategory)
                HStack {
                    Text(business.formattedRating)
                    Image("star")
                }
            }
            Spacer()
        }
    }
}

@available(iOS 15.0, *)
struct BusinessCell_Previews: PreviewProvider {
    static var previews: some View {
        BusinessCell(
            business: .init(
                rating: 4.5,
                price: nil,
                phone: nil,
                id: nil,
                alias: nil,
                isClosed: nil,
                categories: [.init(alias: nil, title: "Cafe")],
                reviewCount: nil,
                name: "Blue bottle",
                url: nil,
                coordinates: nil,
                imageURL: "https://s3-media1.fl.yelpcdn.com/bphoto/j_Ut4i4j2Q4d2TVEDPVt4g/o.jpg",
                location: nil,
                distance: nil,
                transactions: nil
            )
        )
    }
}
