//
//  WordFetcher.swift
//  FallingWordsApp
//
//  Created by hiralee malaviya on 09.11.19.
//  Copyright © 2019 hiralee malaviya. All rights reserved.
//

import Foundation

protocol WordFetchable {
    func fetchWordsLocally() -> [Word]?
    func fetchWordsRemotely(completion: @escaping ([Word]) -> Void)
}

class WordFetcher: WordFetchable {
    func fetchWordsLocally() -> [Word]? {
        var words: [Word]?
        
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                words = try JSONDecoder().decode([Word].self, from: data)
            } catch {
                print("Unable to fetch words locally")
            }
        }

        return words
    }
    
    func fetchWordsRemotely(completion: @escaping ([Word]) -> Void) {
        let service = WordService(client: WordHTTPClient(session: URLSession(configuration: .default)))
        service.url = URL(string: WordService.wordBaseURL)
        
        service.load { [weak self] (result) in
            guard self != nil else {
                return
            }
            
            switch result {
            case let .success(words):
                completion(words)
            case .failure(_):
                completion([])
            }
        }
    }
}
