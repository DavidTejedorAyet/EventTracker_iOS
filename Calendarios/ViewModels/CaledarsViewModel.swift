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
    @Published var selectedCalendar: CalendarModel = CalendarModel(name: "(Sin nombre)", iconName: "questionmark", iconColor: "#ffffff") 
    @Published var selectedMarkedDate: MarkedDateModel?
    @Published var selectedDate: Date? {
        didSet {
            selectedMarkedDate = selectedCalendar.markedDates?.first(where: {Calendar.current.compare($0.date, to: selectedDate ?? Date(), toGranularity: .day) == .orderedSame})
        }
    }
    
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
    
    func addMark(date: Date, completion: () -> () = {}) {

            if let markedDate = self.selectedMarkedDate {
                markedDate.timesMarked += 1
            } else {
                let markedDate = MarkedDateModel(date: date)
                self.selectedMarkedDate = markedDate
                markedDate.timesMarked = 1
                selectedCalendar.markedDates?.append(markedDate)
            }
            StoredDataManager.save()
            loadCalendars()
        
    }
    
    func removeMark(date: Date, id: UUID, completion: () -> Void) {
        
    }
    
    func editNote(markedDate: MarkedDateModel, note: String) {
        
    }
}

