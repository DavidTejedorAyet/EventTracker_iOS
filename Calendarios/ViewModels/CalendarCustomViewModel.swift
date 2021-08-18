//
//  CalendarCustomViewModel.swift
//  Calendarios
//
//  Created by David on 17/8/21.
//

import Foundation
import FSCalendar

protocol CalendarViewDelegate {
    func dateDidSelected(date: Date)
}

class CalendarCustomViewModel: NSObject, ObservableObject {
    
    var calendarModel: CalendarModel!
    var delegate: CalendarViewDelegate?
    var calendar: FSCalendar! {
        didSet {
            calendar.allowsMultipleSelection = false
            calendar.dataSource = self
            calendar.delegate = self
            loadView()
        }
    }
    

}

extension CalendarCustomViewModel: FSCalendarDelegateAppearance {
    func loadView() {
        
        calendar.appearance.headerTitleColor = UIColor(named: "PrimaryColor")
        calendar.appearance.weekdayTextColor = UIColor(named: "PrimaryColor")
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 24)
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 22)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 18)
        calendar.appearance.titleDefaultColor = UIColor(named: "TextColor")
        calendar.appearance.todayColor = .clear
        calendar.appearance.selectionColor = .clear
        calendar.appearance.borderSelectionColor = UIColor(named: "PrimaryColor")
        calendar.appearance.eventDefaultColor = UIColor(named: "PrimaryColor")
        
        calendar.locale = Locale(identifier: "es_ES")
        calendar.firstWeekday = 2
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.clipsToBounds = true
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0;

    }
}

extension CalendarCustomViewModel: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        debugPrint("did select date \(date.getString(format: "dd-MM-yyyy"))")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        delegate?.dateDidSelected(date: date)
    }
    
    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
        return true
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if let markedDates = Array(calendarModel.markedDates?) {
        }
//        for markedDate in calendarModel.markedDates ?? [] {
//            
//            if markedDate.date == date {
//                return 1
//            }
//        }
        return 0
    }
}
