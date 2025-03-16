//
//  WebServicesManager.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//


import Foundation


protocol WebServicesManager {
    func performAPIRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, any Error>) -> Void)
}

class WebServicesManagerImplementation: WebServicesManager {

    func performAPIRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, any Error>) -> Void) {
        let serverCommunication = ServerCommunicationGateway()
        serverCommunication.executeServerCommunicationWithURLRequest(with: request, completion: { result in
            completion(result)
        })
    }
}


