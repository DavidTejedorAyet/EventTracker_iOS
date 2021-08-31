//
//  CalendarDetailView.swift
//  Calendarios
//
//  Created by David on 12/8/21.
//

import SwiftUI



struct CalendarDetailView: View {
    @EnvironmentObject var viewModel: CalendarsViewModel
    @State var selectedCalendar: CalendarModel
    @State var isMarked = false
    
    @State var updater = false

    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                
                CalendarCustomView(updater: $updater, selectedCalendar: $selectedCalendar)
                    .background(Color("BackgroundColor"))
                    .frame(height: 350)
                
                Spacer()
                    .frame(height: 30)
                
                Text("\(viewModel.selectedDate?.getString(format: "dd MM yyyy") ?? "") marcado \(viewModel.selectedMarkedDate?.timesMarked ?? -1) veces")
                
                Button(action: {
                    if let date = viewModel.selectedDate {
                        viewModel.addMark(date: date)
                        isMarked = true
                        updater.toggle()
                        
                    }
                    
                }){
                    if (isMarked) {
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 65, height: 65, alignment: .center)
                            .padding(22)
                            .background(Color("PrimaryColor"))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    } else {
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 65, height: 65, alignment: .center)
                            .padding(22)
                            .background(Color(.white))
                            .foregroundColor(.black)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    
                }
                
                Spacer()
            }
            .navigationTitle(viewModel.selectedCalendar.name)
            .onAppear() {
                viewModel.selectedCalendar = selectedCalendar
            }
            
        }
    }
}

struct CalendarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self, content: CalendarDetailView(selectedCalendar: CalendarModel(name: "", iconName: "", iconColor: "")).preferredColorScheme)
            .environmentObject(CalendarsViewModel())
    }
}

