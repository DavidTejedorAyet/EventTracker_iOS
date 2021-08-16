//
//  CalendarFormView.swift
//  Calendarios
//
//  Created by David on 12/8/21.
//

import SwiftUI

struct CalendarFormView: View {
    
    @StateObject var viewModel = CalendarsViewModel()
    var calendar: CalendarModel?
    @State private var showPopUp = false

    
    @State var name: String = ""
    @State var iconName: String = "star"
    @State var iconColor: Color = .blue
    
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
            ScrollView(.vertical) {
                VStack() {
                    HStack(alignment: .center) {
                        ZStack {
                            Image(systemName: iconName)
                                .resizable()
                                .frame(width: 70, height: 70, alignment: .center)
                                .padding(12)
                                .background(iconColor)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 4)
                            
                            Text("Editar")
                                .padding(4)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .shadow(radius: 4)
                                .offset(y:52)
                            
                        }.onTapGesture {
                            withAnimation {
                                showPopUp.toggle()
                            }
                        }
                        
                        VStack(alignment: .leading){
                            Text("Nombre")
                                .font(.headline)
                            TextField("Nombre", text: $name)
                        }.padding()
                    }
                    .padding()
                    
                    
                    
                    Spacer().frame(height: 50)
                    
                    Button(action: {
                        viewModel.addCalendar(name: name, imageColor: iconColor, icon: iconName)
                    }, label: {
                        Text("GUARDAR")
                    })
                    .disabled(name.isEmpty)
                    
                }.padding()
            }
            
            if $showPopUp.wrappedValue {
                IconPickerPopUp(delegate: self)
            }
        }
            .navigationBarTitle("Nuevo calendario")
    }
    

}

extension CalendarFormView: IconPickerPopUpDelegate {
    func closePopUp(color: Color, icon: String) {
        iconName = icon
        iconColor = color
        withAnimation {
            showPopUp.toggle()
        }
        
    }
    
    
}

struct CalendarFormView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarFormView()
    }
}
