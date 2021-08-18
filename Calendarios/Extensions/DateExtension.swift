//
//  DateExtension.swift
//  Calendarios
//
//  Created by David on 17/8/21.
//

import Foundation

extension Date {
    func getString(format: String) -> String {
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter
        }()
        return formatter.string(from: self)
        
    }
}
