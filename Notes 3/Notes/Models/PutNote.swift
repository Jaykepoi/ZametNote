//
//  PutNote.swift
//  Notes
//
//  Created by Mikhail Kim on 22.11.2021.
//

import Foundation

struct PutNote: Decodable {
    let id: Int
    let author: String
    let title: String
    let text: String
//    let created: "2021-12-14T18:07:08.521Z"
//    let update: "2021-12-14T18:07:08.521Z"
    let is_active: Bool
//    let is_favorites: Bool
}
