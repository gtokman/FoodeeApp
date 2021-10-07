//
//  BusinessCell.swift
//  Foodee
//
//  Created by Gary Tokman on 9/24/21.
//

import ExtensionKit
import SwiftUI

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
                    .font(.custom(.poppinsSemibold, size: .large))
                Text(business.formattedCategory)
                    .font(.custom(.poppinsRegular, size: 14))
                    .foregroundColor(.gray)
                HStack {
                    Text(business.formattedRating)
                        .font(.custom(.poppinsRegular, size: .large))
                    Image("star")
                }
            }
            Spacer()
        }
        .foregroundColor(.black)
        .padding(.small)
        .background(Color.white)
        .cornerRadius(.large)
        .modifier(ShadowModifier())
    }
}

@available(iOS 15.0, *)
struct BusinessCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BusinessCell(
                business: .init(
                    id: nil,
                    alias: nil,
                    name: "Sweetgreen",
                    imageURL: "https://s3-media1.fl.yelpcdn.com/bphoto/j_Ut4i4j2Q4d2TVEDPVt4g/o.jpg",
                    isClaimed: nil,
                    isClosed: nil,
                    url: nil,
                    phone: nil,
                    displayPhone: nil,
                    reviewCount: nil,
                    categories: nil,
                    rating: 4.5,
                    location: nil,
                    coordinates: nil,
                    photos: nil,
                    price: nil,
                    hours: nil,
                    transactions: nil,
                    specialHours: nil
                )
            )
            BusinessCell(
                business: .init(
                    id: nil,
                    alias: nil,
                    name: "Sweetgreen",
                    imageURL: "https://s3-media1.fl.yelpcdn.com/bphoto/j_Ut4i4j2Q4d2TVEDPVt4g/o.jpg",
                    isClaimed: nil,
                    isClosed: nil,
                    url: nil,
                    phone: nil,
                    displayPhone: nil,
                    reviewCount: nil,
                    categories: nil,
                    rating: 4.5,
                    location: nil,
                    coordinates: nil,
                    photos: nil,
                    price: nil,
                    hours: nil,
                    transactions: nil,
                    specialHours: nil
                )
            )
            .environment(\.colorScheme, .dark)
        }
    }
}
