//
//  IconPickerPopUp.swift
//  Calendarios
//
//  Created by David on 13/8/21.
//

import SwiftUI

protocol IconPickerPopUpDelegate {
    func closePopUp(color: Color, icon: String)
}

struct IconPickerPopUp: View {
    
    var delegate: IconPickerPopUpDelegate?
    @State var selectedIcon: String = ""
    @State var selectedColor: Color = .white
    
    
    var pickableColors: [Color] = [.red, .blue, .pink, .black, .white, .gray, .purple, .yellow, .orange]
    var pickableIcons: [String] = ["star", "heart", "circle"]
    
    var body: some View {
        
        ZStack {
            Color("PopupBackground")
                .onTapGesture {
                    withAnimation {
                        delegate?.closePopUp(color: selectedColor, icon: selectedIcon)
                    }
                    
                }
            
            ZStack {
                Color("BackgroundColor")
                VStack (){
                    Text("Icono")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(pickableIcons, id: \.self) { icon in
                                Image(systemName: icon)
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .padding(12)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                                    .onTapGesture {
                                        selectedIcon = icon
                                    }
                            }
                        }
                        .padding(.vertical, 10)
                        
                    }
                    .frame(width: 300)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Text("Color")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(pickableColors, id: \.self) { color in
                                color
                                    .frame(width: 55, height: 55)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 4)
                                    .padding(.vertical, 10)
                                    .onTapGesture {
                                        selectedColor = color
                                    }
                                
                            }
                        }
                        
                    }.frame(width: 300)
                    
                    Spacer()
                    
                    Image(systemName: selectedIcon)
                        .resizable()
                        .frame(width: 70, height: 70, alignment: .center)
                        .padding(12)
                        .background(selectedColor)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 4)
                    
                    Spacer()
                        .frame(height: 30)
                    
                }.padding()
            }
            .frame(width: 300, height: 460)
            .cornerRadius(20)
            .shadow(radius: 10)
            
        }.ignoresSafeArea()
        
    }
}

struct IconPickerPopUp_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerPopUp()
    }
}
