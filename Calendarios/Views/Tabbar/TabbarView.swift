//
//  TabbarView.swift
//  Pruebas
//
//  Created by David on 12/8/21.
//

import SwiftUI

struct TabbarIcon: View {
    @StateObject var tabbarController: TabbarController
    let width, height: CGFloat
    let systemIconName, tabName: String
    let assignedPage: Page
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }.padding(.horizontal, -4)
        .foregroundColor(tabbarController.currentPage == assignedPage ? Color("TabBarHighlight") : Color("TabBarItem"))
        .onTapGesture {
            tabbarController.currentPage = assignedPage
        }
    }
}

struct TabbarView: View {
    @StateObject var tabbarController: TabbarController
    @State var showPopUp = false
    
    var geometry: GeometryProxy
    var body: some View {
        
        HStack {
            TabbarIcon(tabbarController: tabbarController, width: geometry.size.width/CGFloat(Page.allCases.count + 1), height: geometry.size.height/28, systemIconName: "list.bullet", tabName: "Calendarios", assignedPage: .List)
            
            NavigationLink(destination: CalendarFormView()) {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 62, height: 62)
                        .shadow(radius: 4)
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 55 , height: 55)
                        .foregroundColor(Color("PrimaryColor"))
                        .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                }
            }.offset(y: -geometry.size.height/8/2)
            
            
            TabbarIcon(tabbarController: tabbarController, width: geometry.size.width/CGFloat(Page.allCases.count + 1), height: geometry.size.height/28, systemIconName: "person.fill", tabName: "Perfil", assignedPage: .Profile)
        }
        .frame(width: geometry.size.width, height: geometry.size.height/8)
        .background(Color("TabBarBackground").shadow(radius: 3))
    }
    
    
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text("Home")
                Spacer()
                TabbarView(tabbarController: TabbarController(), geometry: geometry)
                
            }
            
        }.edgesIgnoringSafeArea(.bottom)
    }
}
