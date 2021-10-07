//
//  CategoryView.swift
//  Foodee
//
//  Created by Gary Tokman on 9/24/21.
//

import SwiftUI

struct CategoryView: View {

    @Binding var selectedCategory: FoodCategory
    let category: FoodCategory

    var body: some View {
        Button(action: { selectedCategory = category }) {
            HStack {
                Text(category.emoji)
                    .font(.title)
                Text(category.rawValue.capitalized)
                    .font(.custom(.poppinsSemibold, size: 14))
            }
        }
        .padding(.small)
        .padding(.horizontal, .medium)
        .background(selectedCategory == category ? Color.red : .white)
        .cornerRadius(20)
        .padding(.top, .small)
        .padding(.bottom, .large)
        .modifier(ShadowModifier())
        .foregroundColor(.black)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(selectedCategory: .constant(.coffee), category: .coffee)
    }
}
