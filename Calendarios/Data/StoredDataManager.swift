//
//  StoredDataManager.swift
//  Calendarios
//
//  Created by David on 18/8/21.
//

import Foundation

class StoredDataManager: Codable {
    
    static var current = StoredDataManager()
    private static let kArchiveKey = "AKWWD3"
    
    var calendars: [CalendarModel] = []

    private init() {

        if let data = UserDefaults.standard.object(forKey: StoredDataManager.kArchiveKey) as? Data {
            if let savedSession = try? PropertyListDecoder().decode(StoredDataManager.self, from: data) {
                calendars = savedSession.calendars
            }
        }
    }
    
    
    static func clean(){
        UserDefaults.standard.removeObject(forKey: kArchiveKey)
        current = StoredDataManager()
    }
    
    
    static func save() {
        if let data = try? PropertyListEncoder().encode(current) {
            UserDefaults.standard.set(data, forKey: kArchiveKey)
        }
    }
}
