//
//  CartViewModel.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import Foundation

@MainActor
class CartViewModel: ObservableObject {
    @Published var storage: MovieStorageManagerProtocol
    
    init(storage: MovieStorageManagerProtocol) {
        self.storage = storage
    }
    
    var isEmpty: Bool {
        storage.items.isEmpty ||
        storage.items.contains(where: { $0.quantity != 0 })
    }
    
    var cartItems: [CartItem] {
        storage.items.filter { $0.quantity > 0 }
    }
    
    var totalQuantity: String {
        "\(storage.totalQuantity)"
    }
    
    var totalPrice: String {
        storage.totalPrice.asBrazilianCurrency
    }
    
    var apiRequestError: Error? {
        storage.apiRequestError
    }
    
    func removeProduct(with productID: Int) {
        storage.resetQuantity(for: productID)
    }
    
    func decreaseQuantity(for productID: Int) {
        storage.decreaseQuantity(for: productID)
    }
    
    func increaseQuantity(for productID: Int) {
        storage.increaseQuantity(for: productID)
    }
    
    func confirmPurchase() {
        storage.resetAllQuantity()
    }
}
