//
//  BeyondEnums.swift
//  BeyondEnums
//
//  Created by JAVIER CALATRAVA LLAVERIA on 4/1/26.
//

import Foundation

public struct ImageURL: Codable, Equatable {
    let url: String
    
    public init(_ url: String) {
        self.url = url
    }
}

public struct FeedImageURL: Codable, Equatable {
    public let feeds: [ImageURL]
    public let timestamp: Date
    
    public init(feeds: [ImageURL], timestamp: Date) {
        self.feeds = feeds
        self.timestamp = timestamp
    }
}

public typealias ResultImageURL = Result<FeedImageURL?, Error>
public typealias CompletionImageURL = (ResultImageURL) -> Void

public func fetchFeed( completion: @escaping (ResultImageURL) -> Void) {
    
    guard let url = URL(string: "https://picsum.photos/v2/list") else { return }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error { completion(.failure(error)); return }
        
        guard let data else { completion(.success(.none)); return }
        do {
            let feedResponse = try JSONDecoder().decode(FeedImageURL.self, from: data)
            completion(.success(feedResponse))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}

public func processFeedRequest() {
    
    fetchFeed() { result in
        switch result {
        case .success(.some(let feedResponse)):
            print("Feed Response: \(String(describing: feedResponse))")
        case .success(.none):
            print("No feed response")
        case .failure(let error):
            print("Error: \(error)")
        }
    }
}
