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
                    .font(.custom(.poppinsSemibold, size: 18))
                    .foregroundColor(.black)
                Text(business.formattedCategories)
                    .font(.custom(.poppinsRegular, size: 12))
                    .foregroundColor(.gray)
                    .padding(.bottom, .large)
            }

            Group {
                HStack {
                    Image(Asset.map.name)
                    Button(action: navigate) {
                        Text(business.formattedAddress)
                    }
                    Image(Asset.star.name)
                    Text(business.formattedRating)
                        .foregroundColor(.black)
                    Image(Asset.money.name)
                    Text(business.formattedPrice)
                        .foregroundColor(.black)
                }.font(.subheadline)
            }
            .font(.custom(.poppinsRegular, size: 14))

            Group {
                HStack {
                    Image(Asset.clock.name)
                    Text(business.dayOfTheWeek)
                        .foregroundColor(.black)
                    Image(Asset.phone.name)
                    Button(action: phone) {
                        Text(business.formattedPhoneNumber)
                    }
                    Spacer()
                }
                .font(.subheadline)
                .padding(.bottom, .large)
            }
            .font(.custom(.poppinsRegular, size: 14))

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
                .frame(height: 290)
                .cornerRadius(.large)
                .tabViewStyle(.page)
            }

        }
        .padding().padding()
        .background(Color.white)
        .cornerRadius(.xLarge)
        .modifier(ShadowModifier())
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.65)

    }

    func phone() {
        UIApplication.shared.openPhone(calling: business.phone ?? "")
    }

    func navigate() {
        let query = "\(business.coordinates?.latitude ?? 0),\(business.coordinates?.longitude ?? 0)"
        UIApplication.shared.openExternalMapApp(query: query)
    }
}

@available(iOS 15.0, *)
struct DetailCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
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
            .environment(\.colorScheme, .dark)
        }
    }
}
