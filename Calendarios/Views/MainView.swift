//
//  MainView.swift
//  Calendarios
//
//  Created by David on 10/8/21.
//

import SwiftUI

struct MainView: View {
    @StateObject var tabbarController: TabbarController
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    switch tabbarController.currentPage {
                    case .List:
                        CalendarListView()
                            .navigationTitle("Lista")
                    case .Profile:
                        ProfileView()
                            .navigationTitle("Perfil")
                    }
                    Spacer()
                    
                    TabbarView(tabbarController: tabbarController, geometry: geometry)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color("BackgroundColor").ignoresSafeArea())
        }
        .accentColor(Color("PrimaryColor"))
        .environmentObject(CalendarsViewModel())
    }

    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: MainView(tabbarController: TabbarController()).preferredColorScheme)
    }
}
