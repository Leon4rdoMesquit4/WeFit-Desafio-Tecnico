//
//  StorageManagerProtocol.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 27/04/25.
//

import SwiftUI

@MainActor
protocol MovieStorageManagerProtocol {
    var items: [CartItem] { get set }
    var apiRequestError: Error? { get set }
    var totalQuantity: Int { get }
    var totalPrice: Double { get }
    
    func loadFromAPI() async throws
    func increaseQuantity(for productID: Int)
    func decreaseQuantity(for productID: Int)
    func resetQuantity(for productID: Int)
    func resetAllQuantity()
}
