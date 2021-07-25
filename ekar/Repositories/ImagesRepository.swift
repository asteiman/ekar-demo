//
//  ImagesRepository.swift
//  ekar
//
//  Created by Alan Steiman on 23/07/2021.
//

import Foundation
import Combine

protocol ImagesRepositoryProtocol: WebRepository {
    func getBy(make: String, model: String) -> AnyPublisher<[String], GenericError>
}

class ImagesRepository: ImagesRepositoryProtocol {
    
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getBy(make: String, model: String) -> AnyPublisher<[String], GenericError> {
        return call(endpoint: API.images(key: Config.apiKey, make: make, model: model))
            .mapError { error in
                GenericError.network
            }
            .map({ (response: ImagesResponse) in
                return Array(response.images.map { $0.link }.filter { $0.contains("https://") }.prefix(5))
            })
            .eraseToAnyPublisher()
    }
}

extension ImagesRepository {
    enum API {
        case images(key: String, make: String, model: String)
    }
}

extension ImagesRepository.API: APICall {

    var path: String {
        switch self {
        case .images(let key, let make, let model):
            return "/images?key=\(key)&make=\(make.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&model=\(model.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
        }
    }

    var method: String {
        switch self {
        case .images:
            return "GET"
        }
    }

    var headers: [String: String]? {
        return nil
    }

    func body() throws -> Data? {
        return nil
    }
}
