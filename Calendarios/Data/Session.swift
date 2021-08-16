//
//  Session.swift
//  Temp
//
//  Created by Miguel Estévez on 29/10/2018.
//  Copyright © 2018 Vanadis. All rights reserved.
//
//  This class stores and preserves all information related to the session (if present) that user created
//  in the server-side of application. I should save token, expiration dates, keychain information, user identifiers, etc
//  ... Example of a serializable-persistent Singleton in Swift 4.0
//

import Foundation

class Session: Codable {
    
    static var current = Session()
    private static let kArchiveKey = "AE4545"
    var token: String?
    var userModel: UserModel?
    var fcmToken: String?
    
    internal var isValid: Bool {
        get {
            return token != nil
        }
    }
    private init() {

        if let data = UserDefaults.standard.object(forKey: Session.kArchiveKey) as? Data {
            if let savedSession = try? PropertyListDecoder().decode(Session.self, from: data) {
                token = savedSession.token
                print("user token: \n\(token ?? "No Token saved")")
                userModel = savedSession.userModel
                fcmToken = savedSession.fcmToken
            }
        }
    }
    
    
    static func clean(){
        UserDefaults.standard.removeObject(forKey: kArchiveKey)
        current = Session()
    }
    
    
    static func save() {
        
        if let data = try? PropertyListEncoder().encode(current) {
            UserDefaults.standard.set(data, forKey: kArchiveKey)
        } 
    }
}
