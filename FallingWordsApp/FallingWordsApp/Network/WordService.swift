import Foundation

@objcMembers
class WordService: NSObject {
    public static let wordBaseURL =
        "https://gist.githubusercontent.com/DroidCoder/7ac6cdb4bf5e032f4c737aaafe659b33/raw/baa9fe0d586082d85db71f346e2b039c580c5804/words.json"
    
    private let client: HTTPClient
    public var url: URL?
    
    public enum Result {
        case success([Word])
        case failure(Error)
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        guard let url = url else {
            completion(.failure(Error.invalidData))
            return
        }
        
        client.get(from: url) { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case let .success(data, response):
                completion(strongSelf.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try WordItemMapper.map(data, from: response)
            return .success(items)
        } catch {
            return .failure(WordService.Error.invalidData)
        }
    }
}

