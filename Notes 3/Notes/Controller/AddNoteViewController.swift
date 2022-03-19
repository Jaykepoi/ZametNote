//
//  DetailViewController.swift
//  Notes
//
//  Created by Mikhail Kim on 07.11.2021.
//

import UIKit

class AddNoteViewController: UIViewController {

    let api = NotesApi.shared
    var addNote: NewNote?
    @IBOutlet weak var titleNoteTextField: UITextField!
    @IBOutlet weak var textNoteTextView: UITextView!
    
    @IBAction func saveNote(_ sender: Any) {
        guard let title = titleNoteTextField.text, let text = textNoteTextView.text else {
            return
        }

        let addSave = NewNote(title: title, text: text)
        api.saveNote(addSave) { success in
            
            if success {
                DispatchQueue.main.async {
                    NoteService.shared.fetchNotes()
                    self.navigationController?.popViewController(animated: true)
                }
                
            } else {
                return
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textNoteTextView.layer.borderWidth = 0.5
        textNoteTextView.layer.borderColor = CGColor(gray: 0.9, alpha: 1.0)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "addNoteSegue" {
//            let vc = segue.destination as! NotesTableViewController
//            if titleNoteTextField.text != nil && titleNoteTextField.text != ""{
//                vc.titleNote = titleNoteTextField.text
//            } else {
//                vc.titleNote = "Заметка"
//            }
//            vc.textNote = textNoteTextView.text
//        }
//    }
    
   
}
