//
//  NetworkManager.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import Alamofire
import Foundation

class NetworkManager {
    
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()

    let reachabilityManager = NetworkReachabilityManager()?.isReachable

    func isConnectedToInternet() -> Bool {
        return reachabilityManager ?? false
    }

    func request<T: Codable>(_ request: URLRequestConvertible,
                             decodeToType type: T.Type,
                             completionHandler: @escaping (Result<T, Error>) -> ()) {
        
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(type.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
