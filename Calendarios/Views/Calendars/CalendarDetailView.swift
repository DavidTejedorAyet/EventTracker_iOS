//
//  CalendarDetailView.swift
//  Calendarios
//
//  Created by David on 12/8/21.
//

import SwiftUI

struct CalendarDetailView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor")
            
        }
    }
}

struct CalendarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: CalendarDetailView().preferredColorScheme)
    }
}
