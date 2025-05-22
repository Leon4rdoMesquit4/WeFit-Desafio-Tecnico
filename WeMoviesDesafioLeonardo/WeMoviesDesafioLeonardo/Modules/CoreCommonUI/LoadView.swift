//
//  LoadView.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 25/04/25.
//

import SwiftUI

struct LoadView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            circle
                .onAppear {
                    isAnimating = true
                }
        }
    }
}

extension LoadView {
    var circle: some View {
        Circle()
            .stroke(
                AngularGradient(
                            gradient: Gradient(stops: [
                                .init(color: .loaderGray1, location: 0),
                                .init(color: .loaderGray2, location: 1)
                            ]),
                            center: .center
                        ),
                lineWidth: 4
            )
            .frame(width: 62, height: 62)
            .rotationEffect(.init(degrees: isAnimating ? 360 : 0))
            .animation(.linear(duration: 1.5).repeatForever(autoreverses: false), value: isAnimating)
    }
}
