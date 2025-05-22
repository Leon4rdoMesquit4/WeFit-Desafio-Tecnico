//
//  Products.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 25/04/25.
//

struct MoviesResponse: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let image: String
}
