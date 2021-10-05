//
//  ShadowModifier.swift
//  Foodee
//
//  Created by Gary Tokman on 10/3/21.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
    }
}
