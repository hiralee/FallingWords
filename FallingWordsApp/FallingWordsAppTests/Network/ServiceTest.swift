//
//  WordServiceTest.swift
//  FallingWordsAppTests
//
//  Created by hiralee malaviya on 09.11.19.
//  Copyright © 2019 hiralee malaviya. All rights reserved.
//

import Foundation
import XCTest
@testable import FallingWordsApp

class ServiceTest: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(fileURLWithPath: "http://a-given-http-url.com")
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(fileURLWithPath: "http://a-given-http-url.com")
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let url = URL(fileURLWithPath: "http://a-given-http-url.com")
        let (sut, client) = makeSUT(url: url)
        
        expect(sut, toCompleteWith: .failure(ServiceError.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0, userInfo: nil)
            client.complete(with: clientError)
        })
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let url = URL(fileURLWithPath: "http://a-given-http-url.com")
        let (sut, client) = makeSUT(url: url)
        let samples =  [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { (arg) in
            let (index, code) = arg
            expect(sut, toCompleteWith: .failure(ServiceError.invalidData), when: {
                client.complete(withStatusCode: code, at: index)
            })
        }
    }

    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let url = URL(fileURLWithPath: "http://a-given-http-u rl.com")
        let (sut, client) = makeSUT(url: url)
        let data = makeItem()
        
        expect(sut, toCompleteWith: .success(data), when: {
            client.complete(withStatusCode: 200, data: data)
        })
    }
    
    // MARK: Helpers
    
    func makeSUT(url: URL = URL(fileURLWithPath: "http://a-given-http-url.com")) -> (sut: Service, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = Service(client: client, url: url)
        return (sut, client)
    }
    
    private func expect(_ sut: Service, toCompleteWith expectedResult: ServiceResult, when action: () -> Void) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems.count, expectedItems.count)
            case let (.failure(receivedError as ServiceError), .failure(expectedError as ServiceError)):
                XCTAssertEqual(receivedError, expectedError)
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead")
            }
            exp.fulfill()
        }
        
        action()
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func makeItem() -> Data {
        let json: Data = "{\"text_eng\": \"word\", \"text_spa\": \"translation\"}".data(using: .utf8)!
        return json
    }
}

