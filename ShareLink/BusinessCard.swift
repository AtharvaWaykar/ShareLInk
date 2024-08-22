//
//  BusinessCard.swift
//  ShareLink
//
//  Created by Atharva Waykar on 8/21/24.
//

import Foundation

struct BusinessCard: Codable, Identifiable {
    var id = UUID()
    var name: String
    var jobTitle: String
    var company: String
    var phoneNumber: String
    var email: String
    
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    static func fromData(_ data: Data) -> BusinessCard? {
        return try? JSONDecoder().decode(BusinessCard.self, from: data)
    }
}
