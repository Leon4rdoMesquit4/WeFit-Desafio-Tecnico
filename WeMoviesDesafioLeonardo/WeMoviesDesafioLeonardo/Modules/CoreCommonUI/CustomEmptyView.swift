//
//  CustomEmptyView.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import SwiftUI

struct CustomEmptyView: View {
    let mode: Mode
    let action: (() -> Void)?
    let lastAdded: Date? = .now
    
    var body: some View {
        VStack {
            titleLabel
            Spacer(minLength: 24)
            image
            Spacer(minLength: 24)
            button
        }
        .padding(24)
        .background {
            Color.backgroundSecondary
        }
        .clipShape(.rect(cornerRadius: 4))
    }
}

extension CustomEmptyView {
    var titleLabel: some View {
        VStack(spacing: 4) {
            if mode == .cartConfirmedPurchase, let lastAdded = lastAdded {
                HStack(spacing: 0) {
                    Text("Compra realizada em ")
                        .font(.openSansRegular(size: 12))
                    Text(lastAdded.toBrazilianFormat(.ddMMyyyy))
                        .font(.openSansBold(size: 12))
                    Text(" às ")
                        .font(.openSansRegular(size: 12))
                    Text(lastAdded.toBrazilianFormat(.HHmm))
                        .font(.openSansBold(size: 12))
                }
                .foregroundStyle(Color.textDark4)
            }
            HStack {
                Spacer()
                Text(mode.titleText)
                    .font(.openSansBold(size: 20))
                    .foregroundStyle(Color.textDark1)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
    }
    var image: some View {
        Image(mode.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    var button: some View {
        Button {
            action?()
        } label: {
            Text(mode.buttonText)
                .font(.openSansBold(size: 12))
                .foregroundStyle(Color.textLight)
                .padding(.vertical, 12)
                .frame(width: 174)
                .background {
                    Color.customButton
                }
                .clipShape(.rect(cornerRadius: 4))
        }
    }
}

extension CustomEmptyView {
    enum Mode {
        case cart
        case cartConfirmedPurchase
        case home
        
        var titleText: String {
            switch self {
            case .cart, .home:
                "Parece que não há nada por aqui :("
            case .cartConfirmedPurchase:
                "Compra realizada com sucesso!"
            }
        }
        var buttonText: String {
            switch self {
            case .cart, .cartConfirmedPurchase:
                "Voltar à Home"
            case .home:
                "Recarregar Página"
            }
        }
        var image: ImageResource {
            switch self {
            case .cart:
                .emptyCart
            case .cartConfirmedPurchase:
                .successfulPayment
            case .home:
                .emptyHome
            }
        }
    }
}

#Preview {
    CustomEmptyView(mode: .cartConfirmedPurchase) {
        print("Empty View Clicked")
    }
}
