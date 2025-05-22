//
//  Color+Extension.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 25/04/25.
//

import SwiftUI

extension Color {
    //MARK: - Background
    static let backgroundTertiary: Color = .init(hex: "#1D1D2B")
    static let backgroundSecondary: Color = .init(hex: "#FFFFFF")
    static let backgroundPrimary: Color = .init(hex: "#2F2E41")
    
    //MARK: - Button
    static let customButton: Color = .init(hex: "#009EDD")
    static let customButtonCartSelected: Color = .init(hex: "#039B00")
    
    //MARK: - Text
    static let textLight: Color = .init(hex: "#FFFFFF")
    static let textDark1: Color = .init(hex: "#2F2E41")
    static let textDark2: Color = .init(hex: "#333333")
    static let textDark3: Color = .init(hex: "#999999")
    static let textDark4: Color = .init(hex: "#A1A1A1")
    
    //MARK: - Gradient
    //loader
    static let loaderGray1: Color = .init(hex: "#808080").opacity(0) //stop 87%
    static let loaderGray2: Color = .init(hex: "#E6E6E6") //stop 87%
    
    //tabbar
    static let tabbarWhite1: Color = .init(hex: "#FFFFFF").opacity(0) //stop 100%
    static let tabbarWhite2: Color = .init(hex: "#FFFFFF").opacity(0.12) //stop 0%
    
    //MARK: - Stroke
    static let strokeGray1: Color = .init(hex: "999999")
    static let strokeGray2: Color = .init(hex: "D9D9D9")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
