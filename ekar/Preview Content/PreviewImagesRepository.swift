//
//  PreviewImagesRepository.swift
//  ekar
//
//  Created by Alan Steiman on 23/07/2021.
//

import Foundation
import Combine

class PreviewImagesRepository: ImagesRepositoryProtocol {
    var session: URLSession = .shared
    
    var baseURL: String = ""
    
    var bgQueue: DispatchQueue = DispatchQueue(label: "")
    
    func getBy(make: String, model: String) -> AnyPublisher<[String], GenericError> {
        return Just([
            "https://www.leasetechs.com/wp-content/uploads/2018/04/Civic-Sedan-1279x719.jpg",
            "https://wallpapercave.com/wp/wp7301270.jpg"
        ]).setFailureType(to: GenericError.self).eraseToAnyPublisher()
    }
}
