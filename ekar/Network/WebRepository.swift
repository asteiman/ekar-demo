//
//  WebRepository.swift
//  ekar
//
//  Created by Alan Steiman on 16/07/2021.
//

import Foundation
import Combine

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension WebRepository {
    func call<T: Decodable>(endpoint: APICall, httpCodes: HTTPCodes = .success) -> AnyPublisher<T, APIError> {
        guard let request = try? endpoint.urlRequest(baseURL: baseURL) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        print(request.url!.absoluteURL)

        return session.dataTaskPublisher(for: request)
            .requestJSON(httpCodes: httpCodes)
            .mapError { error in
                return error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - Helpers

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<T: Decodable>(httpCodes: HTTPCodes) -> AnyPublisher<T, APIError> {
        let decoder = JSONDecoder()

        return tryMap {
            assert(!Thread.isMainThread)
            guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                throw APIError.unexpectedResponse
            }
            guard httpCodes.contains(code) else {
                throw APIError.httpCode(code)
            }
            return $0.0
        }
        .decode(type: T.self, decoder: decoder)
        .mapError { error -> APIError in
            guard let apiError = error as? APIError else {
                return .unexpectedResponse
            }
            return apiError
        }
        .eraseToAnyPublisher()
    }
}
