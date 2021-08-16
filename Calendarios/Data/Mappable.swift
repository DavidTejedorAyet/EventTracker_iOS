//
//  Mappable.swift
//  BdeoSDK
//
//  Created by Miguel Estévez on 24/05/2019.
//  Copyright © 2019 Miguel Estévez. All rights reserved.
//

import Foundation

protocol Mappable: Codable {
    init?(jsonData: Data?)
    init?(jsonString: String)
    init?<T: Decodable>(jsonData: Data?, type: T.Type?)
}

extension Mappable {
    init?(jsonData: Data?) {
        guard let data = jsonData else { return nil }
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        }
        catch {
            return nil
        }
    }
    
    init?(jsonString: String) {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        self.init(jsonData: data)
    }
    
    init?<T: Decodable>(jsonData: Data?, type: T.Type? = nil) {
        guard let data = jsonData else { return nil }
        do {
            if let type = type {
                self =  try JSONDecoder().decode(type.self, from: data) as! Self
            }
            else {
                self = try JSONDecoder().decode(Self.self, from: data)
            }
        }
        catch {
            return nil
        }
    }
}
