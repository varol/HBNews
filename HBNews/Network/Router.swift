//
//  Router.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let apiKey = "e15dc43747ee46e9a1568ae7aab55ff5"
    
    case sources
    case topHeadlines(source: String?)
    case everything(source: String?)

    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }

    var method: HTTPMethod {
        switch self {
        case .sources, .topHeadlines, .everything:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        var param: Parameters = [:]
        switch self {
        case .sources:
            return nil
        case .topHeadlines(source: let source):
            if let source = source {
                param["sources"] = source
            }
        case .everything(source: let source):
            if let source = source {
                param["sources"] = source
            }
        }
        return param
    }
    
    private var path: String {
        switch self {
        case .sources:
            return "sources"
        case .topHeadlines(source: _):
            return "top-headlines"
        case .everything(source: _):
            return "everything"
        }
    }

    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        // Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var completeParameters = parameters ?? [:]
        
        // add apiKey
        completeParameters["apikey"] = Router.apiKey
        
        let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
        debugPrint("final url ", urlRequestPrint.url ?? "")
        
        return try encoding.encode(urlRequest, with: completeParameters)
    }
}
