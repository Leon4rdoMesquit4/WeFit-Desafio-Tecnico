//
//  HomeViewModel.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var storage: MovieStorageManagerProtocol
    
    init(storage: MovieStorageManagerProtocol) {
        self.storage = storage
    }
    
    func reloadData() async {
        do {
            try await loadMovies()
        } catch {
            storage.apiRequestError = error
        }
    }
    
    func increaseQuantity(for id: Int) {
        storage.increaseQuantity(for: id)
    }
    
    private func loadMovies() async throws {
        do {
            storage.apiRequestError = nil
            try await storage.loadFromAPI()
        } catch {
            storage.apiRequestError = error
        }
    }
    
    func storageIsEmpty() -> Bool {
        storage.items.isEmpty
    }
    
    func productsIndices() -> Range<Int> {
        storage.items.indices
    }
    
    func productId(at index: Int) -> Int {
        storage.items[index].product.id
    }
    
    func product(at index: Int) -> CartItem {
        return storage.items[index]
    }
    
    var apiRequestError: Error? {
        storage.apiRequestError
    }
}
