//
//  NoteService.swift
//  Notes
//
//  Created by Mikhail Kim on 17.11.2021.
//

import UIKit

class NoteService {
    
    static let shared = NoteService()
    let api = NotesApi.shared
    var noteUpdatedCompletion = [() -> Void]()
    var notes = [Note]() {
        didSet {
            DispatchQueue.main.async {
                self.noteUpdatedCompletion.forEach { $0() }
            }
        }
    }
    
    private init() {
        fetchNotes()
    }
    
    
    
    func fetchNotes() {
        api.getNoteList { [weak self] notes in
            self?.notes = notes ?? []
        }
    }
    
    func removeNote(id: String, note: UpdateNote) {
        api.updateNote(id: id,
                       note: note,
                       removeNote: true) { [weak self] isSuccess in
            
            if isSuccess {
                self?.fetchNotes()
            }
        }
    }
    
    func updateNote(id: String,
                    note: UpdateNote) {
        
        api.updateNote(id: id,
                       note: note) { [weak self] isSuccess in
            
            if isSuccess {
                self?.fetchNotes()
            }
        }
    }
    
}
