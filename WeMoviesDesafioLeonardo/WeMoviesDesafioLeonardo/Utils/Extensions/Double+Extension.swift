//
//  Double+Extension.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import Foundation

extension Double {
    var asBrazilianCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: self)) ?? "R$0,00"
    }
}
