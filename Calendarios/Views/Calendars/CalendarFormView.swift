//
//  CalendarFormView.swift
//  Calendarios
//
//  Created by David on 12/8/21.
//

import SwiftUI

struct CalendarFormView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject private var viewModel: CalendarsViewModel
    var calendar: CalendarModel?
    @State private var showPopUp = false

    
    @State var name: String = ""
    @State var iconName: String = "star"
    @State var iconColor: Color = .red
    
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            ScrollView(.vertical) {
                VStack() {
                    HStack(alignment: .center) {
                        ZStack {
                            Image(systemName: iconName)
                                .resizable()
                                .frame(width: 70, height: 70, alignment: .center)
                                .padding(15)
                                .background(iconColor)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 4)
                                .foregroundColor(.white)
                            
                            Text("Editar")
                                .padding(.horizontal,8)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .shadow(radius: 4)
                                .offset(y:52)
                                .foregroundColor(.black)
                            
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
                        viewModel.addCalendar(name: name, imageColor: iconColor, icon: iconName) {
                            presentationMode.wrappedValue.dismiss()
                        }

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
        ForEach(ColorScheme.allCases, id: \.self, content: CalendarFormView().preferredColorScheme)
    }
}
