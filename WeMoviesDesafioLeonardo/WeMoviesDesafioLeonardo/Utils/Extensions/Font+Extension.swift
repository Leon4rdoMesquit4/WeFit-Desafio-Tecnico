//
//  Font+Extension.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 25/04/25.
//

import SwiftUI

extension Font {
    static func openSansRegular(size: CGFloat = 20) -> Font {
        Font.custom("OpenSans-Regular", size: size)
    }
    
    static func openSansBold(size: CGFloat = 42) -> Font {
        Font.custom("OpenSans-Bold", size: size)
    }
}
