//
//  BeyondEnumsTests.swift
//  BeyondEnumsTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 4/1/26.
//

import BeyondEnums
import XCTest

final class BeyondEnumsTests: XCTestCase {

    func testExample() throws {
        let expectedResult: ResultImageURL = .success(aFeed)
        let exp = expectation(description: "Wait for cache retrieval")
        
        fetchFeed { retrievedResult in
            switch (expectedResult, retrievedResult) {
            case (.success(.none), .success(.none)),
                 (.failure, .failure):
                break
                
            case let (.success(.some(expected)), .success(.some(retrieved))):
                XCTAssertEqual(retrieved.feeds, expected.feeds)
                XCTAssertEqual(retrieved.timestamp, expected.timestamp)
                
            default:
                XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK :- Helpers
    var aFeed: FeedImageURL {
        FeedImageURL(feeds: [anyURL], timestamp: Date())
    }
    
    var anyURL: ImageURL {
        ImageURL("https://sample.url.org")
    }
}
