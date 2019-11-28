import Foundation

extension String {
    static let wordURL = "https://gist.githubusercontent.com/DroidCoder/7ac6cdb4bf5e032f4c737aaafe659b33/raw/baa9fe0d586082d85db71f346e2b039c580c5804/words.json"
}

public enum ServiceResult {
    case success(Data)
    case failure(Error)
}

public enum ServiceError: Swift.Error {
    case connectivity
    case invalidData
}

protocol ServiceProtocol {
    func load(completion: @escaping (ServiceResult) -> Void)
}

class Service: ServiceProtocol {
    private static var OK_200: Int { return 200 }
    
    private let client: HTTPClientProtocol
    private let url: URL
    
    public init(client: HTTPClientProtocol, url: URL) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (ServiceResult) -> Void) {
        client.get(from: url) { [weak self] (result) in
            guard self != nil else {
                return
            }
            
            switch result {
            case let .success(data, response):
                guard response.statusCode == Service.OK_200 else {
                    completion(.failure(ServiceError.invalidData))
                    return
                }
                completion(.success(data))
            case .failure:
                completion(.failure(ServiceError.connectivity))
            }
        }
    }
}

