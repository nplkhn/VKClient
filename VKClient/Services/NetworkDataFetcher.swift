//
//  NetworkDataFetcher.swift
//  VKClient
//
//  Created by Никита Плахин on 10/24/20.
//

import Foundation

class NetworkDataFetcher {
    
    private let authService: AuthService
    let networkService: Networking
    
    init(networking: Networking, authService: AuthService = AppDelegate.shared().authService) {
        self.networkService = networking
        self.authService = authService
    }
    
    func getWall() {
        
    }
    
    func getUser(response: @escaping (UserWrapper.User) -> Void) {
        let params = ["fields": "photo_100,bdate,country,city,status,education"]
        
        networkService.request(path: API.user, params: params) { (jsonData, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let data = jsonData {
                let decoder = JSONDecoder()
                do {
                    
                    let user = try decoder.decode(UserWrapper.self, from: data)
                    if let user = user.response.first {
                        DispatchQueue.main.async {
                            response(user)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
