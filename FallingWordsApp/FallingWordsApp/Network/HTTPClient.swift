import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClientProtocol {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public class HTTPClient: HTTPClientProtocol {
    
    private let session: URLSession
    private struct UnexpectedValuesRepresentation: Error {}
    
    @objc public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
            
            }.resume()
    }
}
