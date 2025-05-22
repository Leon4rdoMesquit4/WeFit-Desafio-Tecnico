//
//  CartMovieCardView.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import SwiftUI

struct CartMovieCardView: View {
    var cartItem: CartItem
    let increaseAction: () -> Void
    let decreaseAction: () -> Void
    let removeAction: () -> Void
    @State var reloadID: UUID = .init()
    
    var body: some View {
        VStack(spacing: 21) {
            HStack {
                movieInfo
                Spacer(minLength: 16)
                deleteButton
            }
            
            HStack {
                quantityControl
                Spacer()
                priceInfo
            }
            divider
        }
    }
}

extension CartMovieCardView {
    var movieInfo: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: cartItem.product.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
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
            .frame(width: 56, height: 72)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(cartItem.product.title)
                    .font(.openSansBold(size: 14))
                    .foregroundStyle(Color.textDark1)
                    .lineLimit(2)
                HStack(spacing: 0) {
                    Text("Adicionado em ")
                        .font(.openSansRegular(size: 12))
                    Text(formattedDate(for: cartItem))
                        .font(.openSansBold(size: 12))
                }.foregroundStyle(Color.textDark4)
            }
        }
    }
    var deleteButton: some View {
        Button {
            removeAction()
        } label: {
            Image(.removeIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 18)
        }
    }
    var quantityControl: some View {
        HStack(spacing: 12) {
            quantityButton(mode: .decrease) {
                decreaseAction()
            }
            Text("\(cartItem.quantity)")
                .foregroundStyle(Color.textDark1)
                .lineLimit(1)
                .frame(width: 59)
                .padding(.vertical, 4)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 1)
                        .fill(Color.strokeGray2)
                }
            quantityButton(mode: .increase) {
                increaseAction()
            }
        }
    }
    @ViewBuilder
    func quantityButton(mode: QuantityMode, action: @escaping (() -> Void)) -> some View {
        Button {
            action()
        } label: {
            Image(mode == .increase ? .plusIcon : .minusIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18)
        }
        
    }
    var priceInfo: some View {
        VStack (alignment: .trailing, spacing: 0) {
            Text("SUBTOTAL")
                .font(.openSansBold(size: 12))
                .foregroundStyle(Color.textDark3)
            Text(totalPrice)
                .font(.openSansBold(size: 16))
                .foregroundStyle(Color.textDark1)
        }
    }
    var divider: some View {
        Divider()
            .frame(height: 1)
            .overlay(Color.strokeGray1)
    }
}

extension CartMovieCardView {
    var totalPrice: String {
        (cartItem.product.price * Double(cartItem.quantity)).asBrazilianCurrency
    }
    
    func formattedDate(for item: CartItem) -> String {
        if let date = item.dateAddedToCart {
            return date.toBrazilianFormat(.ddMMyyyy)
        }
        return Date.now.toBrazilianFormat(.ddMMyyyy)
    }
    
    enum QuantityMode {
        case increase
        case decrease
    }
}
