//
//  CalendarDetailView.swift
//  Calendarios
//
//  Created by David on 12/8/21.
//

import SwiftUI



struct CalendarDetailView: View {
    @StateObject var calendarModel: CalendarModel
    @State var selectedDate: Date?
    @StateObject private var viewModel = CalendarsViewModel()

    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                CalendarCustomView(calendarModel: calendarModel, selectedDate: $selectedDate)
                    .background(Color("BackgroundColor"))
                    .frame(height: 350)
                Spacer()
                Text(selectedDate?.getString(format: "dd-MM-yyyy") ?? "")
                Button("Dia marcado") {
                    if let date = selectedDate {
                        viewModel.markDate(date: date, calendar: calendarModel)
                    }
                }
            }
            .navigationTitle(calendarModel.name ?? "(Sin nombre)")
            
                
        }
    }
}

struct CalendarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self, content: CalendarDetailView(calendarModel: CalendarModel(context: PersistenceController.shared.container.viewContext)).preferredColorScheme)
    }
}

