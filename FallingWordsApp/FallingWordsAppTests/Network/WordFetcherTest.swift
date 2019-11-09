//
//  WordFetcherTest.swift
//  FallingWordsAppTests
//
//  Created by hiralee malaviya on 09.11.19.
//  Copyright © 2019 hiralee malaviya. All rights reserved.
//

import Foundation
import XCTest
@testable import FallingWordsApp

class WordFetcherTest: XCTestCase {
    
    func test_wordFetcher_returnsWordFetcherSpy() {
        XCTAssertNotNil(makeSUT())
    }
    
    func test_wordFetcher_returnsWordsLocally() {
        let sut = makeSUT()
        
        sut.fetchWordsLocally { (words) in
            XCTAssertNotNil(words)
            XCTAssertEqual(words.count, 1)
        }
    }
    
    func test_wordFetcher_returnsWordsRemotely() {
        let sut = makeSUT()
        
        var wordsFetched: [Word]?
        sut.fetchWordsRemotely { (words) in
            wordsFetched = words
        }
        
        XCTAssertNotNil(wordsFetched)
        XCTAssertEqual(wordsFetched?.count, 1)
    }
    
    func makeSUT() -> WordFetchable {
        return WordFetcherSpy()
    }
    
    class WordFetcherSpy: WordFetchable {
        func fetchWordsLocally(completion: @escaping ([Word]) -> Void)  {
            completion([Word(word: "word", translation: "translation")])
        }
        
        func fetchWordsRemotely(completion: @escaping ([Word]) -> Void) {
            completion([Word(word: "word", translation: "translation")])
        }
    }
}
