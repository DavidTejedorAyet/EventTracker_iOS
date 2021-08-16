//
//  ProfileVC.swift
//  CEF App
//
//  Created by David Tejedor on 03/04/2020.
//  Copyright © 2020 Miguel Estévez. All rights reserved.
//

import Foundation

class UserModel: Mappable {
    
    var token: String?
    var userInfo: UserInfo?
    
    private enum CodingKeys: String, CodingKey {
        case token
        case userInfo = "user_info"
    }
    
}

class UserInfo: Mappable {
    var name: String?
    var firstSurname: String?
    var secondSurname: String?
    var id: String?
    var phone: String?
    var email: String?
    var avatar: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case firstSurname = "first_surname"
        case secondSurname = "second_surname"
        case id
        case phone
        case email
        case avatar
    }
}
