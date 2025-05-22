//
//  NetworkManagerProtocol.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 27/04/25.
//

protocol NetworkManagerProtocol {
    func getMovies() async throws(NetworkError) -> [Product]
}
