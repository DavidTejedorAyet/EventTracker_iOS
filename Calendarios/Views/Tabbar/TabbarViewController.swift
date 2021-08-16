//
//  TabbarViewController.swift
//  Pruebas
//
//  Created by David on 12/8/21.
//

import SwiftUI

enum Page: CaseIterable {
     case List
     case Profile
 }

class TabbarViewController: ObservableObject {
    @Published var currentPage: Page = .List

}
