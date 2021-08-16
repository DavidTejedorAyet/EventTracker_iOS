//
//  MainView.swift
//  Calendarios
//
//  Created by David on 10/8/21.
//

import SwiftUI

struct MainView: View {
    @StateObject var tabbarController: TabbarViewController
    
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
            }.edgesIgnoringSafeArea(.bottom)
        }
        .accentColor(Color("PrimaryColor"))
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: MainView(tabbarController: TabbarViewController()).preferredColorScheme)
    }
}