//
//  MovieClient.swift
//  UIKitMoviesApp
//
//  Created by James Rochabrun on 7/9/20.
//

import Foundation
import Combine

class MovieClient: GenericAPIClient, ObservableObject {
    
    let session: URLSession
    @Published var items: [Movie] = []


    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getFeed(from movieFeedType: MovieFeed, completion: @escaping (Result<MovieFeedResult?, APIError>) -> Void) {
        
        fetch(with: movieFeedType.request , decode: { json in
            guard let movieFeedResult = json as? MovieFeedResult else { return  nil }
            self.items = movieFeedResult.results
            return movieFeedResult
        }, completion: completion)
    }
}


protocol RemoveThis: AnyObject {
    func update(_ movies: [Movie])
}
final class MovieModel: ObservableObject {
    
    private let client = MovieClient()
    
    weak var delegate: RemoveThis?
    @Published var items: [Movie] = []
    
    init() {
        client.getFeed(from: .nowPlaying) { result in
            switch result {
            case .success(let movieFeedResult):
                guard let movieResults = movieFeedResult?.results else { return }
                self.items = movieResults
                self.delegate?.update(self.items)
              //  dump(movieResults)
                print("step 2")
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
}
