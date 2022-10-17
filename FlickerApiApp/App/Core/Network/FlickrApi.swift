//
//  FlickrApi.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 16.10.2022.
//

import Foundation
import Moya

let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .default))
let provider = MoyaProvider<FlickrApi>(plugins: [plugin])

// TODO: - Search content should be filtered.
enum FlickrApi {
    case getRecentImages(page: String)
    case search(text: String, page: String)
}

// MARK: - TargetType
extension FlickrApi: TargetType{
    
    var baseURL: URL {
        guard let url = URL(string: "https://www.flickr.com/services/rest") else {
            fatalError("Base URL not found or not in correct format")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getRecentImages:
            return "/"
        case .search:
            return "/"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self{
        case .getRecentImages(let page):
            let parameters:[String : Any] = ["method": "flickr.photos.getRecent",
                              "api_key": "b4e2d5855cd63ed362d1e1dd3d981dc7",
                              "page": page,
                              "format": "json",
                              "nojsoncallback": "1",
                              "extras" : "date_taken,owner_name,url_n"
                              ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .search(let text, let page):
            let parameters:[String : Any] = ["method": "flickr.photos.search",
                              "api_key": "b4e2d5855cd63ed362d1e1dd3d981dc7",
                              "page": page,
                              "text": text,
                              "format": "json",
                              "nojsoncallback": "1",
                              "extras" : "date_taken,owner_name,url_n"
                              ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}

