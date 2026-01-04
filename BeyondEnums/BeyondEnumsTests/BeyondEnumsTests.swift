//
//  BeyondEnumsTests.swift
//  BeyondEnumsTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 4/1/26.
//

import BeyondEnums
import XCTest

final class BeyondEnumsTests: XCTestCase {
    
    public struct LocalFeedImage: Equatable {
        public let id: UUID
        public let description: String?
        public let location: String?
        public let url: URL
        
        public init(id: UUID, description: String?, location: String?, url: URL) {
            self.id = id
            self.description = description
            self.location = location
            self.url = url
        }
    }
    
    public typealias CacheFeed = (feed: [LocalFeedImage], timestamp: Date)
    typealias RetrievalResult = Swift.Result<CacheFeed?, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void

    func testExample() throws {
        let expectedResult: ResultImageURL = .success(.none)
//        let expectedResult: CompletionImageURL = { _ in .success(.none) }
//        fetchFeed() { receivedResult in
//            
//        }
    }
    
    func expect(/*_ sut: FeedStore,*/ toRetrieve expectedResult: RetrievalResult, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for cache retrieval")
        
        fetchFeed { retrievedResult in
            switch (expectedResult, retrievedResult) {
            case (.success(.none), .success(.none)),
                 (.failure, .failure):
                break
                
            case let (.success(.some(expected)), .success(.some(retrieved))):
              //  XCTAssertEqual(retrieved.feed, expected.feed, file: file, line: line)
             //   XCTAssertEqual(retrieved.timestamp, expected.timestamp, file: file, line: line)
                
            default:
                XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }

}
