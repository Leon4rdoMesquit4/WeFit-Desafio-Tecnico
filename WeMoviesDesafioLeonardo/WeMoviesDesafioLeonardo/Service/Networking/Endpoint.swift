//
//  Endpoint.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 25/04/25.
//

import Foundation

enum Endpoint {
    static var popularMovies: URL? {
        URL(string: "https://wefit-movies.vercel.app/api/movies")
    }
}
