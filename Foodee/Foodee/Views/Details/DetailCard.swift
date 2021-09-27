//
//  DetailCard.swift
//  Foodee
//
//  Created by Gary Tokman on 9/26/21.
//

import ExtensionKit
import SwiftUI

@available(iOS 15.0, *)
struct DetailCard: View {
    let business: Business
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Group {
                Text(business.formattedName)
                    .bold()
                Text(business.formattedCategory)
                    .font(.subheadline)
            }

            Group {
                HStack {
                    Image("map")
                    Text(business.formattedAddress)
                    Image("star")
                    Text(business.formattedRating)
                    Image("money")
                    Text(business.formattedPrice)
                }
            }

            Group {
                HStack {
                    Image("clock")
                    Text("Open")
                    Image("phone")
                    Text(business.formattedPhoneNumber)
                    Spacer()
                }
                .padding(.bottom, .small)
            }

            Group {
                TabView {
                    ForEach(business.images, id: \.self) { url in
                        AsyncImage.init(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray.shimmer()
                        }

                    }
                }
                .frame(height: 250)
                .cornerRadius(.large)
                .tabViewStyle(.page)
            }

        }
        .padding().padding()
//        .background(Color.red)
//        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.6)

    }
}

@available(iOS 15.0, *)
struct DetailCard_Previews: PreviewProvider {
    static var previews: some View {
        DetailCard(
            business:
                .init(
                    id: nil,
                    alias: nil,
                    name: "Sweetgreen",
                    imageURL: "https://s3-media1.fl.yelpcdn.com/bphoto/j_Ut4i4j2Q4d2TVEDPVt4g/o.jpg",
                    isClaimed: nil,
                    isClosed: nil,
                    url: nil,
                    phone: nil,
                    displayPhone: "(123) 456-7890",
                    reviewCount: nil,
                    categories: [.init(alias: nil, title: "healthy")],
                    rating: 4.5,
                    location: .init(address1: nil, address2: nil, address3: nil, city: nil, zipCode: nil, country: nil, state: nil, displayAddress: ["12 main st"], crossStreets: nil),
                    coordinates: nil,
                    photos: ["https://s3-media1.fl.yelpcdn.com/bphoto/j_Ut4i4j2Q4d2TVEDPVt4g/o.jpg", "https://s3-media1.fl.yelpcdn.com/bphoto/j_Ut4i4j2Q4d2TVEDPVt4g/o.jpg"],
                    price: "$",
                    hours: nil,
                    transactions: nil,
                    specialHours: nil
                )
        )
    }
}
