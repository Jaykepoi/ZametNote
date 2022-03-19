//
//  DetailsTableViewController.swift
//  Notes
//
//  Created by Mikhail Kim on 07.11.2021.
//

import UIKit
import SwipeCellKit

class NotesTableViewController: UITableViewController {
    
    var titleNote: String?
    var textNote: String?
    //    var realm = try! Realm()
    //    var notes: Results<Note>?
    var addNote: NewNote?
    
    //    var selectedCategory: Category?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = addNote?.title
        //        print(realm.configuration.fileURL)
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "noteCell")
        
        NoteService.shared.noteUpdatedCompletion.append {
            self.tableView.reloadData()
        }
    }
     

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUpdateNote",
           let vc = segue.destination as? UpdateNoteViewController,
           let indexPath = sender as? IndexPath {
            
            let note = NoteService.shared.notes[indexPath.row]
            vc.note = note
        }
    }
    
}


extension NotesTableViewController {
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteService.shared.notes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! CustomTableViewCell
        
        let note = NoteService.shared.notes[indexPath.row]
        
        cell.title.text = note.title
        cell.delegate = self
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToUpdateNote", sender: indexPath)
    }
    
}


//MARK: - Swipe delegate method

extension NotesTableViewController: SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive,
                                       title: "Удалить") { [weak self] action, indexPath in
            
            guard let self = self else { return }
            
            let note = NoteService.shared.notes[indexPath.row]
            let updateNote = UpdateNote(note: note)
            
            NoteService.shared.notes.remove(at: indexPath.row)
            NoteService.shared.removeNote(id: String(note.id),
                                          note: updateNote)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsOptionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> SwipeOptions {
        
        var options = SwipeOptions()
        
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        
        return options
    }
    
    
}

