//
//  CalendarListCellView.swift
//  Calendarios
//
//  Created by David on 9/8/21.
//

import SwiftUI

struct CalendarListCellView: View {
    var calendar: CalendarModel
    
    var body: some View {
        ZStack {

            HStack {
                Image(systemName: calendar.iconName ?? "questionmark")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding(15)
                    .background(Color(hex: calendar.iconColor ?? "#ffffff"))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 4)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    Text(calendar.name ?? "(Sin nombre)")
                        .fontWeight(.semibold)
                        .padding(.leading, 12)
                    Spacer()
                    Text("Texto que no se cual será pero que ya me vendrá")
                        .padding(.leading, 12)
                }
                    
                Spacer()
            }
            .padding()
        }
    }
}

struct CalendarListCellView_Previews: PreviewProvider {

    static var previews: some View {
    
        CalendarListCellView(calendar: CalendarModel(name: "Prueba", iconName: "star", iconColor: "aa1a4b"))
    }
}
