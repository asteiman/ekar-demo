//
//  XCTestCase.swift
//  ekarTests
//
//  Created by Alan Steiman on 25/07/2021.
//

import XCTest
import Combine

extension XCTestCase {
    typealias CompletionResult = (expectation: XCTestExpectation, cancellable: AnyCancellable?)

    func expectValue<T: Publisher>(of publisher: T,
                                   count: Int = 1,
                                   timeout _: TimeInterval = 2,
                                   file _: StaticString = #file,
                                   line _: UInt = #line,
                                   equals: [T.Output]?) -> CompletionResult where T.Output: Equatable {
        let exp = expectation(description: "Correct values of " + String(describing: publisher))
        exp.expectedFulfillmentCount = count
        guard var mutableEquals = equals else {
            return (exp, nil)
        }
        let cancellable = publisher
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                      guard mutableEquals.count > 0 else {
                          exp.fulfill()
                          return
                      }
                      if value == mutableEquals.first {
                          mutableEquals.remove(at: 0)
                          if mutableEquals.isEmpty {
                              exp.fulfill()
                          }
                      }
            })
        return (exp, cancellable)
    }
}

