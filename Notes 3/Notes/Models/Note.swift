//
//  Note.swift
//  Notes
//
//  Created by Mikhail Kim on 22.11.2021.
//


struct Note: Codable {
    
    let id: Int
    let author: Int
    let title: String
    let text: String
    let created: String
    let update: String
    let isActive: Bool
    var isFavorites: Bool
    let url: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case title = "title"
        case text = "text"
        case created = "created"
        case update = "update"
        case isActive = "is_active"
        case isFavorites = "is_favorites"
        case url = "url"
    }
}
