//
//  ModuleAEntity.swift
//  Assignment
//
//  Created by Macbook Pro on 04/05/2024.
//

import Foundation

struct Item: Codable {
    let name: String
    let country: String
    let webPages: [String]
    // Add other properties as needed
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case country = "country"
        case webPages = "web_pages"
        // Define other keys if necessary
    }
}

