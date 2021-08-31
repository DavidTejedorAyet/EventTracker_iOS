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

class CustomCalendarController: NSObject, ObservableObject {
    
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
    
    var previousUpdaterState = false
    
    func checkUpdatableData(updatable: Bool) {
        if previousUpdaterState != updatable {
            previousUpdaterState = updatable
            calendar.reloadData()
        }
    }
    
    
}

extension CustomCalendarController: FSCalendarDelegateAppearance {
    func loadView() {
        
        calendar.appearance.headerTitleColor = UIColor(named: "PrimaryColor")
        calendar.appearance.weekdayTextColor = UIColor(named: "PrimaryColor")
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 24)
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 22)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 18)
        calendar.appearance.titleDefaultColor = UIColor(named: "TextColor")
        
        
        calendar.appearance.titleTodayColor = UIColor(named: "TextColor")
        calendar.appearance.titleSelectionColor = UIColor(named: "TextColor")
        
        calendar.appearance.borderSelectionColor = UIColor(named: "PrimaryColor")
        calendar.appearance.eventDefaultColor = UIColor(named: "PrimaryColor")
        
        calendar.locale = Locale(identifier: "es_ES")
        calendar.firstWeekday = 2
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.clipsToBounds = true
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0;

    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        if Calendar.current.compare(date, to: Date(), toGranularity: .day) == .orderedSame {
            return UIColor(hex: calendarModel.iconColor)
        }
        return .clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        for markedDate in calendarModel.markedDates ?? [] {
            if Calendar.current.compare(date, to: markedDate.date, toGranularity: .day) == .orderedSame {
                return UIColor(hex: calendarModel.iconColor) 
                
            }
        }
        return .clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        for markedDate in calendarModel.markedDates ?? [] {
            if Calendar.current.compare(date, to: markedDate.date, toGranularity: .day) == .orderedSame {
                return UIColor(hex: calendarModel.iconColor)
                
            }
        }
        return .clear
    }
}

extension CustomCalendarController: FSCalendarDataSource {
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

        for markedDate in calendarModel.markedDates ?? [] {
            
            if !markedDate.note.isEmpty {
                return 1
            }
        }
        return 0
    }
    
}
