//
//  ServerCommunicationGateway.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation

class ServerCommunicationGateway: NSObject {
    
    private var session = URLSession.shared
    
    override init() {
        super.init()
        
        //MARK: Instantiate Session Configuration
        let sessionConfiguration = URLSessionConfiguration.default
        let operationQueue = OperationQueue.main
        self.session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: operationQueue)
    }
    
    //MARK: Execute HTTP Communication with Server
    func executeServerCommunicationWithURLRequest<T: Decodable>(with requestURL: URLRequest,
                                                  completion: @escaping (Result<T, Error>) -> Void) {
        let dataTask = session.dataTask(with: requestURL) { (data, responseURL, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}

extension ServerCommunicationGateway: URLSessionDelegate {
    
}
