//
//  NetworkService.swift
//  VKClient
//
//  Created by Никита Плахин on 10/23/20.
//

import Foundation
import Alamofire

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    private let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else {
            return
        }
        
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(with: path, params: allParams)
        
        AF.request(url).validate().response { response in
            completion(response.data, response.error)
        }
        
    }
    
    func getImage(from urlString: String?, completion: @escaping (UIImage) -> Void) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        
        AF.request(url).validate().responseData { response in
            if let data = response.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    private func url(with path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
}
