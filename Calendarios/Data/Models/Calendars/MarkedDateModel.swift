//
//  MarkedDateModel.swift
//  Calendarios
//
//  Created by David on 18/8/21.
//

import Foundation

class MarkedDateModel: Mappable, ObservableObject {
  
    var id: UUID = UUID()
    var date: Date
    var note: String = ""
    var timesMarked: Int = 0
    
    internal init(date: Date) {
        self.date = date
    }
}
