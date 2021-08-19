//
//  CalendarModel.swift
//  Calendarios
//
//  Created by David on 18/8/21.
//

import Foundation

struct CalendarModel: Mappable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CalendarModel, rhs: CalendarModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    var id: UUID = UUID()
    var name: String
    var iconName: String
    var iconColor: String
    var markedDates: [MarkedDateModel]?
    
    internal init(name: String, iconName: String, iconColor: String, markedDates: [MarkedDateModel] = []) {
        self.name = name
        self.iconName = iconName
        self.iconColor = iconColor
        self.markedDates = markedDates
    }
}
