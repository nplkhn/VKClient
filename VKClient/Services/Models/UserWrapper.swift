//
//  User.swift
//  VKClient
//
//  Created by Никита Плахин on 10/23/20.
//

import Foundation

// MARK: - UserWrapper
struct UserWrapper: Codable {
    let response: [User]
    
    // MARK: - Response
    struct User: Codable {
        let id: Int
        let firstName, lastName: String
        let isClosed, canAccessClosed: Bool
        let bdate: String?
        let city, country: Place?
        let photo100: String?
        let status: String?
        let university: Int?
        let universityName: String?
        let faculty: Int?
        let facultyName: String?
        let graduation: Int?

        var name: String {
            firstName + " " + lastName
        }
        
        var location: String {
            var components: [String] = []
            if let country = country?.title {
                components.append(country)
            }
            if let city = city?.title {
                components.append(city)
            }
            
            return components.joined(separator: ", ")
        }
        
        var education: String {
            var components: [String] = []
            if let university = universityName, university != "" {
                components.append(university)
            }
            if let faculty = facultyName, faculty != "" {
                components.append(faculty)
            }
            
            return components.joined(separator: ", ")
        }

        enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
            case isClosed = "is_closed"
            case canAccessClosed = "can_access_closed"
            case bdate, city, country
            case photo100 = "photo_100"
            case status, university
            case universityName = "university_name"
            case faculty
            case facultyName = "faculty_name"
            case graduation
        }
        
        // MARK: - City
        struct Place: Codable {
            let id: Int
            let title: String
        }
    }

}
