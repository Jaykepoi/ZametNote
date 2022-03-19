//
//  UpdateNote.swift
//  Notes
//
//  Created by Mikhail Kim on 22.11.2021.
//

import Foundation

struct UpdateNote: Codable {
   
    var title: String
    var text: String
    var created = "2005-08-09T18:31:42"
    var isActive: Bool
    var isFavorites: Bool
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case text = "text"
        case created = "created"
        case isActive = "is_active"
        case isFavorites = "is_favorites"
    }
 
    
    init(title: String,
         text: String,
         created: String = "2005-08-09T18:31:42",
         isActive: Bool,
         isFavorites: Bool) {
        
       self.title = title
       self.text = text
       self.created = created
       self.isActive = isActive
       self.isFavorites = isFavorites
   }
   
   init(note: Note) {
       self.title = note.title
       self.text = note.text
       self.created = note.created
       self.isActive = note.isActive
       self.isFavorites = note.isFavorites
   }
}
