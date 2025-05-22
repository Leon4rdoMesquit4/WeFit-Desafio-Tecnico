//
//  CartProduct.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import Foundation

struct CartItem: Identifiable, Codable {
    var id: UUID
    var product: Product
    var quantity: Int
    var dateAddedToCart: Date?
}
