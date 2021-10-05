//
//  ContentView.swift
//  Foodee
//
//  Created by Gary Tokman on 9/21/21.
//

import SwiftUI

struct PermissionView: View {

    @State var isAnimating = false
    let action: () -> Void
    
    var animation: Animation {
        .interpolatingSpring(stiffness: 0.5, damping: 0.5)
            .repeatForever()
            .delay(isAnimating ? .random(in: 0...1) : 0)
            .speed(isAnimating ? .random(in: 0.1...1) : 0)
    }

    var body: some View {
        GeometryReader { proxy in
            VStack {

                // Images
                ZStack {
                    ForEach(1..<14) { i in
                        Image("food\(i % 7)")
                            .position(
                                x: .random(in: 0...proxy.size.width),
                                y: .random(in: 0...proxy.size.height / 2)
                            )
                            .animation(animation)
                    }
                }.frame(height: proxy.size.height / 3)

                // Text & Button
                Text(L10n.foodee)
                    .font(.custom(.poppinsSemibold, size: 38))
                    .padding(.bottom, .large)

                Text(L10n.findNewCoolSpotsToEat)
                    .font(.custom(.poppinsMedium, size: 16))

                Spacer()

                // Button
                Button(action: action) {
                    Text(L10n.getStarted)
                        .font(.custom(.poppinsMedium, size: 16))
                }
                .padding()
                .frame(maxWidth: proxy.size.width - 50)
                .background(Color.red)
                .cornerRadius(50)
                .modifier(ShadowModifier())
                .foregroundColor(.white)
            }
        }.onAppear {
            isAnimating.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView() {}
    }
}
