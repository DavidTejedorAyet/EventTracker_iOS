//
//  IconPickerPopUpViewModel.swift
//  Calendarios
//
//  Created by David on 13/8/21.
//

import SwiftUI

class IconPickerPopUpViewModel: ObservableObject {
    @Published var pickableColors: [Color] = [.red, .blue, .pink, .black, .white, .gray, .purple, .yellow, .orange]
    
}
