//
//  CustomTab 2.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

enum CustomTab: String, CaseIterable {
    case cart
    case home
    case profile
    
    var title: String {
        switch self {
        case .cart:
            "Carrinho"
        case .home:
            "Home"
        case .profile:
            "Perfil"
        }
    }
    
    var icon: String {
        switch self {
        case .cart:
            "TabBarCartIcon"
        case .home:
            "TabBarHomeIcon"
        case .profile:
            "TabBarProfileIcon"
        }
    }
    
    var isEnabled: Bool {
        self != .profile
    }
}
