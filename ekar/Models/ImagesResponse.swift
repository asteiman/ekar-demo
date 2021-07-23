//
//  ImagesResponse.swift
//  ekar
//
//  Created by Alan Steiman on 23/07/2021.
//

import Foundation

struct ImagesResponse: Codable {
    let images: [ImageResponse]
    
    struct ImageResponse: Codable {
        let link: String
    }
}
