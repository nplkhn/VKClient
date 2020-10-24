//
//  API.swift
//  VKClient
//
//  Created by Никита Плахин on 10/23/20.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.124"
    
    static let newsFeed = "/method/wall.get"
    static let user = "/method/users.get"
}
