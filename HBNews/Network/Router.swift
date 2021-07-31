//
//  Router.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
//    static let apiKey = "e15dc43747ee46e9a1568ae7aab55ff5"
//    static let apiKey = "cd2f25cd0dc5414192b2dbf46e80773e"
//    static let apiKey = "f4412fb833304457a36ee5f32629a698"
//    static let apiKey = "6443dc1f81aa412484f137493dd130e2"
    static let apiKey = "946fc4a1132a43d2bbe341f536617621"

    case sources
    case topHeadlines(source: String?)
    case everything(source: String?, page: Int?, qInTitle: String?)

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
        case .everything(source: let source, page: let page, qInTitle: let qInTitle):
            if let source = source {
                param["sources"] = source
            }
            
            if let page = page {
                param["page"] = page
            }
            
            if let qInTitle = qInTitle {
                param["qInTitle"] = qInTitle
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
