//
//  WordFetcher.swift
//  FallingWordsApp
//
//  Created by hiralee malaviya on 09.11.19.
//  Copyright © 2019 hiralee malaviya. All rights reserved.
//

import Foundation

protocol WordFetchable {
    func fetchWordsLocally(completion: @escaping ([Word]) -> Void)
    func fetchWordsRemotely(completion: @escaping ([Word]) -> Void)
}

class WordFetcher: WordFetchable {
    func fetchWordsLocally(completion: @escaping ([Word]) -> Void) {
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let words = try JSONDecoder().decode([Word].self, from: data)
                completion(words)
            } catch {
                print("Unable to fetch words locally")
            }
        }
    }
    
    func fetchWordsRemotely(completion: @escaping ([Word]) -> Void) {
        guard let url = URL(string: .wordURL) else {
            completion([])
            return
        }
        
        let service = Service(client: HTTPClient(session: URLSession(configuration: .default)), url: url)
        
        service.load { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let data):
                guard let words = strongSelf.decodeWord(data: data) else {
                    completion([])
                    return
                }
                completion(words)
                
            case .failure(let error):
                completion([])
            }
        }
    }
    
    private func decodeWord(data: Data) -> [Word]? {
        guard let words = try? JSONDecoder().decode([Word].self, from: data) else {
            return nil
        }
        
        return words
    }
}
