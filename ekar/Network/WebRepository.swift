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

private extension Publisher {
    /// Holds the downstream delivery of output until the specified time interval passed after the subscription
    /// Does not hold the output if it arrives later than the time threshold
    ///
    /// - Parameters:
    ///   - interval: The minimum time interval that should elapse after the subscription.
    /// - Returns: A publisher that optionally delays delivery of elements to the downstream receiver.

    func ensureTimeSpan(_ interval: TimeInterval) -> AnyPublisher<Output, Failure> {
        let timer = Just<Void>(())
            .delay(for: .seconds(interval), scheduler: RunLoop.main)
            .setFailureType(to: Failure.self)
        return zip(timer)
            .map { $0.0 }
            .eraseToAnyPublisher()
    }
}
