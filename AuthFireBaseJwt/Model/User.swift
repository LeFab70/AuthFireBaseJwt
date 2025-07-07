//
//  User.swift
//  AuthFireBaseJwt
//
//  Created by Fabrice Kouonang on 2025-07-06.
//

import Foundation
struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
  
    var initials: String {
        let formatter=PersonNameComponentsFormatter()
        if let components=formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    
}

extension User{
    static var MOCK_USER: User=User(
        id: NSUUID().uuidString,
        fullName: "Mat Nolane",
        email: "mat.nolane@gmail.com"
    )
    
}
