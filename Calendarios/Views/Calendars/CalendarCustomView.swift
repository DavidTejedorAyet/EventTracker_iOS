//
//  CalendarCustomView.swift
//  Calendarios
//
//  Created by David on 16/8/21.
//

import SwiftUI
import FSCalendar

struct CalendarCustomView: UIViewRepresentable {
    var calendarModel: CalendarModel
    @Binding var selectedDate: Date?
    @ObservedObject var viewModel = CalendarCustomViewModel()
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        viewModel.calendar = calendar
        viewModel.delegate = context.coordinator
        viewModel.calendarModel = calendarModel
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, CalendarViewDelegate {
        func dateDidSelected(date: Date) {
            print(date)
            parent.selectedDate = date
            
        }
        
        
        var parent: CalendarCustomView
        
        init(_ calender: CalendarCustomView) {
            self.parent = calender
        }
        
        
    }
    
    struct CalendarCustomView_Previews: PreviewProvider {
        static var previews: some View {
            CalendarCustomView(calendarModel: CalendarModel(name: "Prueba", iconName: "star", iconColor: "aa1a4b"), selectedDate: .constant(Date()))
        }
    }
}
