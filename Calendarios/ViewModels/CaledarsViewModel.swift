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
    
    init() {
        loadCalendars()
    }
    
    func updateView(){
        self.objectWillChange.send()
    }
    
    func loadCalendars() {
        if Session.current.userModel != nil{
            syncData()
        } else {
            loadLocalData()
        }
        updateView()
    }
    
    func syncData() {
    }
    
    func loadLocalData() {
        self.calendars = StoredDataManager.current.calendars
    }
    
    func addCalendar(name: String, imageColor: Color, icon: String, completion: () -> Void) {
        let newCalendar = CalendarModel(name: name, iconName: icon, iconColor: imageColor.toHexadecimal())
        StoredDataManager.current.calendars.append(newCalendar)
        StoredDataManager.save()
        loadCalendars()
        print("**** hay \(calendars.count) calendarios")
        completion()
    }
    
    func deleteCalendar(id: Int) {
        print("borrando", id)
        //         let calendarToRemove = StoredDataManager.current.calendars[id]
        StoredDataManager.current.calendars.remove(at: id)
        StoredDataManager.save()
        loadCalendars()
        //        CalendarStorage.shared.delete(id: id)
    }
    
    func markDate(date: Date, note: String = "", calendar: CalendarModel) {
        let markedDate = MarkedDateModel(date: date)
        //        CalendarStorage.shared.markDate(date: date, calendar: calendar)
    }
    
    func editNote(markedDate: MarkedDateModel, note: String) {
        
    }
}

