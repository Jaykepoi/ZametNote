//
//  UpdateNoteViewController.swift
//  Notes
//
//  Created by Mihail Kim on 07.11.2021.
//

import UIKit

class UpdateNoteViewController: UIViewController {
    
    @IBOutlet weak var titleNoteTextField: UITextField!
    @IBOutlet weak var textNoteTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var note: Note?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textNoteTextView.layer.borderWidth = 0.5
        textNoteTextView.layer.borderColor = CGColor(gray: 0.5, alpha: 1.0)
        
        titleNoteTextField.text = note?.title
        textNoteTextView.text = note?.text
        
        setupFavoriteButton()
    }
    
    @IBAction func updateButtonAction(_ sender: Any) {
        guard let note = note,
              let noteTitle = titleNoteTextField.text,
              let noteText = textNoteTextView.text
        else { return }
        
        var updatedNote = UpdateNote(note: note)
        
        updatedNote.title = noteTitle
        updatedNote.text = noteText
        
        NoteService.shared.updateNote(id: String(note.id),
                                      note: updatedNote)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        note?.isFavorites.toggle()
        setupFavoriteButton()
    }
    
    
    
    private func setupFavoriteButton() {
        if note?.isFavorites == true {
            favoriteButton.image = UIImage(systemName: "star.fill")
        } else {
            favoriteButton.image = UIImage(systemName: "star")
        }
    }
    
}
