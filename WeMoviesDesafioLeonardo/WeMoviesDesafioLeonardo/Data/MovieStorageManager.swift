//
//  MovieStorageManager.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import SwiftUI

@MainActor
class MovieStorageManager: ObservableObject, MovieStorageManagerProtocol {
    @Published var items: [CartItem] = []
    @Published var apiRequestError: Error?
    @AppStorage("cartItems") private var cartData: Data = Data()
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
        loadCart()
    }
    
    private func loadCart() {
        guard !cartData.isEmpty,
              let decoded = try? JSONDecoder().decode([CartItem].self, from: cartData)
        else { return }
        items = decoded
    }
    
    private func saveCart() {
        if let encoded = try? JSONEncoder().encode(items) {
            cartData = encoded
        }
    }
    
    func loadFromAPI() async throws {
        do {
            let productsAPI = try await networkManager.getMovies()
            items = productsAPI.map { apiProduct in
                if let movie = items.first(where: { appStorageProduct in
                    apiProduct.id == appStorageProduct.product.id
                }) {
                    CartItem(id: movie.id, product: apiProduct, quantity: movie.quantity, dateAddedToCart: movie.dateAddedToCart)
                } else {
                    CartItem(id: .init(), product: apiProduct, quantity: 0, dateAddedToCart: nil)
                }
            }
            saveCart()
        } catch {
            throw error
        }
    }
    
    func increaseQuantity(for productID: Int) {
        guard let index = items.firstIndex(where: {
            $0.product.id == productID
        }) else {
            return
        }
        let lastQuantity = items[index].quantity
        guard lastQuantity < 99 else { return }
        
        items[index].quantity = items[index].quantity + 1
        if items[index].quantity == 1 && lastQuantity == 0 {
            items[index].dateAddedToCart = .now
            items[index].id = .init()
        }
        saveCart()
    }
    
    func decreaseQuantity(for productID: Int) {
        guard let index = items.firstIndex(where: {
            $0.product.id == productID
        }) else {
            return
        }
        if items[index].quantity <= 1 {
            return
        }
        items[index].quantity = items[index].quantity - 1
        saveCart()
    }
    
    func resetQuantity(for productID: Int) {
        guard let index = items.firstIndex(where: {
            $0.product.id == productID
        }) else {
            return
        }
        items[index].quantity = 0
        saveCart()
    }
    
    func resetAllQuantity() {
        for index in items.indices {
            items[index].quantity = 0
        }
        saveCart()
    }
    
    var totalQuantity: Int {
        if apiRequestError != nil {
            return 0
        } else {
            return items.reduce(0) {
                $0 + $1.quantity
            }
        }
    }
    
    var totalPrice: Double {
        return items.reduce(0) {
            $0 + Double($1.product.price) * Double($1.quantity)
        }
    }
}
