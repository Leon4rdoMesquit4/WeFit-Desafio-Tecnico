//
//  MockCartStorage.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 27/04/25.
//

@testable import WeMoviesDesafioLeonardo
import Foundation

class MockMovieStorageManager: MovieStorageManagerProtocol {
    @Published var items: [CartItem] = []
    @Published var apiRequestError: Error?

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
    
    var failApiRequest: Bool = false
    
    private(set) var loadFromAPICalled = false
    private(set) var increaseQuantityCalledId: Int? = nil
    private(set) var decreaseQuantityCalledWithId: Int? = nil
    private(set) var resetAllQuantityCalled = false
    private(set) var resetQuantityCalledWithId: Int? = nil

    func loadFromAPI() async throws {
        if failApiRequest {
            throw TestError()
        } else {
            loadFromAPICalled = true
        }
    }
    
    func increaseQuantity(for productID: Int) {
        increaseQuantityCalledId = productID
    }
    
    func decreaseQuantity(for productID: Int) {
        decreaseQuantityCalledWithId = productID
    }
    
    func resetQuantity(for productID: Int) {
        resetQuantityCalledWithId = productID
    }
    
    func resetAllQuantity() {
        resetAllQuantityCalled = true
    }
    
    func reset() {
        loadFromAPICalled = false
        resetAllQuantityCalled = false
        increaseQuantityCalledId = nil
        decreaseQuantityCalledWithId = nil
        resetQuantityCalledWithId = nil
        items = []
        apiRequestError = nil
    }
}

struct TestError: Error {
    
}
