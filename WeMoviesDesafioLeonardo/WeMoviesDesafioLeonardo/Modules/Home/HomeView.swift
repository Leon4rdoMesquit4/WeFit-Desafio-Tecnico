//
//  HomeView.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel
    let reloadAction: (() -> Void)?
    
    var body: some View {
        ZStack {
            background
            if viewModel.apiRequestError != nil || viewModel.storageIsEmpty() {
                emptyView
                .padding([.horizontal, .top], 24)
                .padding(.bottom, 72)
            } else {
                VStack {
                    label
                        .padding(24)
                    moviesList
                    .padding(.horizontal, 24)
                    Spacer()
                }
            }
        }
        .task {
            await viewModel.reloadData()
        }
    }
}

extension HomeView {
    var background: some View {
        Color
            .backgroundPrimary
            .ignoresSafeArea()
    }
    var emptyView: some View {
        CustomEmptyView(mode: .home) {
            Task {
                await viewModel.reloadData()
            }
            reloadAction?()
        }
    }
    var label: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Mais vendidos")
                    .font(.openSansBold(size: 20))
                Text("Maiores sucessos do WeMovies")
                    .font(.openSansRegular(size: 12))
            }
            .foregroundStyle(Color.textLight)
            Spacer()
        }
    }
    var moviesList: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(viewModel.productsIndices(), id: \.self) { movieIndex in
                    HomeMovieCardView(cartProduct: viewModel.product(at: movieIndex)) {
                        viewModel.increaseQuantity(for: viewModel.productId(at: movieIndex))
                    }
                }
            }
            .padding(.bottom, 62)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView(viewModel: .init(storage: MovieStorageManager()), reloadAction: {
        print("Reload button clicked")
    })
}
