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
        HStack {
            Image(systemName: calendar.icon ?? "questionmark")
                .resizable()
                .frame(width: 70, height: 70, alignment: .center)
                .padding(12)
                .background(Color(hex: calendar.iconColor ?? "ffffff"))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 4)
            Text(calendar.name ?? "Nombre")
            Spacer()
        }
        .padding()
    }
}

struct CalendarListCellView_Previews: PreviewProvider {

    static var previews: some View {
    
        CalendarListCellView(calendar: CalendarModel(context: PersistenceController.shared.container.viewContext))
    }
}
