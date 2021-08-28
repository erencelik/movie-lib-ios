//
//  NetworkManager.swift
//  Movie Lib
//
//  Created by Eren on 28.08.2021.
//

import Alamofire
import ObjectMapper

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Mappable>(_ url: URL, method: HTTPMethod = .get, parameters: [String: Any]? = nil, responseType: T.Type, _ completion: @escaping ((T) -> ()), _ failure: @escaping ((Error?) -> ())) {
        
        let request = Alamofire.Session.default.request(url, method: method, parameters: parameters)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let object  = Mapper<T>().map(JSONObject: data) else {
                    failure(NetworkError.parsingError)
                    return
                }
                completion(object)
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
        
    }
    
}

enum NetworkError: Error {
    
    case parsingError
    
}

extension NetworkError: LocalizedError {
    
    private var errorDescription: String {
        switch self {
        case .parsingError: return "Response could not be parsed!"
        }
    }
    
}


