//
//  Router.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case sources
    
    var baseURL: URL {
        switch self {
        case .sources:
            return URL(string: "https://newsapi.org/v2/sources?apiKey=e15dc43747ee46e9a1568ae7aab55ff5")!
        }
    }

    var method: HTTPMethod {
        switch self {
        case .sources:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .sources:
            return nil
        }
    }
    
    var url: URL {
        switch self {
        case .sources:
            return URL(string: "https://newsapi.org/v2/sources?apiKey=e15dc43747ee46e9a1568ae7aab55ff5")!
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}
