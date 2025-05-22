//
//  Date+Extension.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import Foundation

extension Date {
    func toBrazilianFormat(_ format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: self)
    }
    
    enum DateFormat: String {
        case ddMMyyyy = "dd/MM/yyyy"
        case HHmm = "HH:mm"
    }
}
