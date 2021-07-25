//
//  Config.swift
//  ekar
//
//  Created by Alan Steiman on 25/07/2021.
//

import Foundation

struct Config {
    static var baseUrl: String {
        return Bundle.main.infoDictionary!["BASE_URL"] as! String
    }
    
    static var apiKey: String {
        return Bundle.main.infoDictionary!["API_KEY"] as! String
    }
}
