//
//  MarkedDateModel.swift
//  Calendarios
//
//  Created by David on 18/8/21.
//

import Foundation

struct MarkedDateModel: Mappable {
  
    var id: UUID = UUID()
    var date: Date
    var note: String
    
    internal init(date: Date, note: String = "") {
        self.date = date
        self.note = note
    }
}
