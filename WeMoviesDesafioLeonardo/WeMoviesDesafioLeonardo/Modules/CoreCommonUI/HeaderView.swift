//
//  HeaderView.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 25/04/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            title
                .padding()
        }
        .background(
            Color
                .backgroundTertiary
        )
    }
}

extension HeaderView {
    var title: some View {
        Text("WeMovies")
            .font(.openSansBold(size: 20))
            .foregroundStyle(Color.textLight)
            .frame(maxWidth: .infinity)
    }
}
