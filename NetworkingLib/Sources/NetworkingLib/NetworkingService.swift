import Foundation

public typealias NetworkingResponse<T: Decodable> = (Result<T, NetworkingError>) -> Void

public protocol NetworkingProtocol {
    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping NetworkingResponse<T>)
}

public class NetworkService: NetworkingProtocol {
    
    public init() {}
    
    let session = URLSession.shared
    
    public func request<T: Decodable>(endpoint: Endpoint, completion: @escaping NetworkingResponse<T>) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        guard let url = urlComponents.url else {
            completion(.failure(NetworkingError.custom("Invalid URL")))
            return
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(NetworkingError.custom(error.localizedDescription)))
                }
            } else if let data = data {
                do {
                    guard let decode = try? JSONDecoder().decode(T.self, from: data) else {
                        DispatchQueue.main.async {
                            completion(.failure(NetworkingError.decode))
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(.success(decode))
                    }
                }
            }
        }
        task.resume()
    }
}
