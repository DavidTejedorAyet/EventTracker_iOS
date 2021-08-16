//
//  CaledarModelView.swift
//  Calendarios
//
//  Created by David on 9/8/21.
//

import SwiftUI
import CoreData
import Combine

class CalendarsViewModel: ObservableObject {
    
    @Published var calendars: [CalendarModel] = [CalendarModel]()
    private var cancellable: AnyCancellable?
    
    init() {
        loadCalendars()
    }
    
    func loadCalendars() {
        if Session.current.userModel != nil{
            syncData()
        } else {
            loadLocalData()
        }
    }
    
    func syncData() {
    }
    
    func loadLocalData(calendarPublisher: AnyPublisher<[CalendarModel], Never> = CalendarStorage.shared.calendars.eraseToAnyPublisher()) {
        cancellable = calendarPublisher.sink { calendars in
            self.calendars = calendars
        }
    }
    
    func addCalendar(name: String, imageColor: Color, icon: String) {
        CalendarStorage.shared.add(name: name, imageColor: imageColor.toHexadecimal(), icon: icon)
    }
    
    func deleteCalendar(id: Int) {
        CalendarStorage.shared.delete(id: id)
    }
}
