//
//  NoteDto.swift
//  Notes
//
//  Created by Mikhail Kim on 22.11.2021.
//

import Foundation

struct NoteDto: Decodable {
    let id: Int
    let author: Int
    let title: String
    let text: String
//    let created: Date//"2021-12-06T22:14:50.969188",
//    let update: Date//"2021-12-06T22:14:50.969797",
    let is_active: Bool
    let is_favorites: Bool
    let url: String//"http://194.58.108.107/api/notes/50/"
}

