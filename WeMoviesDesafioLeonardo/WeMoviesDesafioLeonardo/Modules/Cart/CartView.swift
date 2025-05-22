//
//  CartView.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import SwiftUI

struct CartView: View {
    @State var viewModel: CartViewModel
    let moveTabAction: (() -> Void)?
    @State var isPurchaseCompleted: Bool = false
    
    var body: some View {
        ZStack {
            background
            VStack(spacing: 24) {
                if !isPurchaseCompleted {
                    titleLabel
                }
                if !viewModel.isEmpty || viewModel.apiRequestError != nil {
                    emptyView
                        .padding(.bottom, 42)
                } else {
                    movieList
                }
                Spacer()
            }
            .padding([.horizontal, .top], 24)
        }
        .onDisappear {
            isPurchaseCompleted = false
        }
    }
}

extension CartView {
    var background: some View {
        Color
            .backgroundPrimary
            .ignoresSafeArea()
    }
    var emptyView: some View {
        CustomEmptyView(mode: isPurchaseCompleted ? .cartConfirmedPurchase : .cart) {
            moveTabAction?()
        }
    }
    var titleLabel: some View {
        HStack {
            Text("Carrinho de compras")
                .font(.openSansBold(size: 20))
                .foregroundStyle(Color.textLight)
            Spacer()
        }
    }
    var movieList: some View {
        ScrollView {
            VStack(spacing: 21) {
                ForEach(viewModel.cartItems) { item in
                    CartMovieCardView(cartItem: item) {
                        viewModel.increaseQuantity(for: item.product.id)
                    } decreaseAction: {
                        viewModel.decreaseQuantity(for: item.product.id)
                    } removeAction: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.removeProduct(with: item.product.id)
                        }
                    }
                    .transition(.asymmetric(insertion: .opacity, removal: .push(from: .trailing)))
                }
                
                VStack (spacing: 16){
                    totalPriceLabel
                    button
                }
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background {
                Color
                    .backgroundSecondary
            }
            .clipShape(.rect(cornerRadius: 4))
            .padding(.bottom, 72)
        }
        .scrollIndicators(.hidden)
    }
    var button: some View {
        Button {
            viewModel.confirmPurchase()
            isPurchaseCompleted = true
        } label: {
            HStack {
                Text("FINALIZAR PEDIDO")
                    .font(.openSansBold(size: 14))
            }
            .foregroundStyle(Color.textLight)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background {
                Color.customButton
            }
            .clipShape(.rect(cornerRadius: 4))
        }
    }
    var totalPriceLabel: some View {
        HStack(alignment: .center) {
            Text("TOTAL")
                .font(.openSansBold(size: 14))
                .foregroundStyle(Color.textDark3)
            Spacer()
            Text(viewModel.totalPrice)
                .contentTransition(.identity)
                .font(.openSansBold(size: 24))
                .foregroundStyle(Color.textDark1)
        }
    }

}

#Preview {
    CartView(viewModel: .init(storage: MovieStorageManager())) {
        print("Cart action clicked")
    }
}
