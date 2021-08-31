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
    
    func addCalendar(name: String, imageColor: Color, icon: String) {
        let newCalendar = CalendarModel(name: name, iconName: icon, iconColor: imageColor.toHexadecimal())
        StoredDataManager.current.calendars.append(newCalendar)
        StoredDataManager.save()
        loadCalendars()
    }
    
    func deleteCalendar(id: Int) {
        StoredDataManager.current.calendars.remove(at: id)
        StoredDataManager.save()
        loadCalendars()
    }
    
    func editCalendar(calendar: CalendarModel) {
        if let index = StoredDataManager.current.calendars.firstIndex(where: {$0.id == calendar.id}) {
            StoredDataManager.current.calendars[index] = calendar
            StoredDataManager.current.calendars[index].id = UUID()
            StoredDataManager.save()
            loadCalendars()
        }
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

