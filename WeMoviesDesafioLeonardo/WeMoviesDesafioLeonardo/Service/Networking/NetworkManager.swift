//
//  NetworkManager.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 25/04/25.
//

import Foundation

struct NetworkManager: NetworkManagerProtocol {
    func getMovies() async throws(NetworkError) -> [Product] {
        do {
            guard let url = Endpoint.popularMovies else {
                throw NetworkError.urlUnavailable
            }
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                throw NetworkError.invalidStatusCode(-1)
            }
            
            guard (200...299).contains(statusCode) else {
                throw NetworkError.invalidStatusCode(statusCode)
            }
                        
            let decodedResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
            return decodedResponse.products
        } catch let error as DecodingError {
            throw .decodingFailed(error)
        } catch let error as EncodingError {
            throw .encodingFailed(error)
        } catch let error as URLError {
            throw .requestFailed(error)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw .otherError(error)
        }
    }
}

enum NetworkError: Error {
    case urlUnavailable
    case encodingFailed(EncodingError)
    case decodingFailed(DecodingError)
    case invalidStatusCode(Int)
    case requestFailed(URLError)
    case otherError(Error)
}
