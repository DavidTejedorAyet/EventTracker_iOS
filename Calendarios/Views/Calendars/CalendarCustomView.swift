//
//  CalendarCustomView.swift
//  Calendarios
//
//  Created by David on 16/8/21.
//

import SwiftUI
import FSCalendar

struct CalendarCustomView: UIViewRepresentable {

    @Binding var updater: Bool
    @Binding var selectedCalendar: CalendarModel

    @StateObject var calendarController = CustomCalendarController()
    @EnvironmentObject var viewModel: CalendarsViewModel

    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendarController.calendar = calendar
        calendarController.delegate = context.coordinator
        calendarController.calendarModel = selectedCalendar
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        calendarController.checkUpdatableData(updatable: updater)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, CalendarViewDelegate {
        func dateDidSelected(date: Date) {
            print(date)
            parent.viewModel.selectedDate = date
        }
        
        
        var parent: CalendarCustomView
        
        init(_ calendar: CalendarCustomView) {
            self.parent = calendar
        }
        
        
    }
    
    struct CalendarCustomView_Previews: PreviewProvider {
        static var previews: some View {
            CalendarCustomView(updater: .constant(true), selectedCalendar: .constant(CalendarModel(name: "", iconName: "", iconColor: "")))
        }
    }
}
