//
//  HomeMovieCardView.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import SwiftUI

struct HomeMovieCardView: View {
    var cartProduct: CartItem
    let action: (() -> Void)?
    @State var reloadID: UUID = .init()
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                cardInfo
                button
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background {
                Color
                    .backgroundSecondary
            }
            .clipShape(.rect(cornerRadius: 4))
        }
    }
}

extension HomeMovieCardView {
    var cardInfo: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: cartProduct.product.image)!) { phase in
                switch phase {
                case .empty:
                    LoadView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure(_):
                    Image(systemName: "photo.badge.exclamationmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onAppear {
                            reloadID = .init()
                        }
                @unknown default:
                    EmptyView()
                }
            }
            .id(reloadID)
                .frame(height: 188)
            Text(cartProduct.product.title)
                .font(.openSansBold(size: 12))
                .foregroundStyle(Color.textDark2)
            Text(cartProduct.product.price.asBrazilianCurrency)
                .font(.openSansBold(size: 16))
                .foregroundStyle(Color.textDark1)
        }
    }
    
    var button: some View {
        Button {
            action?()
        } label: {
            HStack {
                Image(.addCartIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                Text("\(cartProduct.quantity)")
                    .font(.openSansBold(size: 12))
                Text("ADICIONAR AO CARRINHO")
                    .font(.openSansBold(size: 12))
            }
            .foregroundStyle(Color.textLight)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background {
                if cartProduct.quantity == 0 {
                    Color.customButton
                } else {
                    Color.customButtonCartSelected
                }
            }
            .clipShape(.rect(cornerRadius: 4))
        }
    }
}
