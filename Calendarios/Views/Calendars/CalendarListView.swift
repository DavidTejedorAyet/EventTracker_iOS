//
//  CalendarListView.swift
//  Calendarios
//
//  Created by David on 9/8/21.
//

import SwiftUI

struct CalendarListView: View {
    
    @EnvironmentObject private var viewModel: CalendarsViewModel
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(viewModel.calendars, id: \.self.id) { calendar in
                        NavigationLink(destination: CalendarDetailView(selectedCalendar: calendar)) {
                            CalendarListCellView(calendar: calendar)
                                
                        }         .listRowBackground(Color("BackgroundColor"))
                        

                    }
                    
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            viewModel.deleteCalendar(id: index)
                        }
                    })
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

struct CalendarListView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self, content: CalendarListView().preferredColorScheme)
            .environmentObject(CalendarsViewModel())
        
    }
}
