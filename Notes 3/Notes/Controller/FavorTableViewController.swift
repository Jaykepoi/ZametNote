//
//  FavorTableViewController.swift
//  Notes
//
//  Created by Mikhail Kim on 07.11.2021.
//

import UIKit
import SwipeCellKit

class FavorTableViewController: UITableViewController{
    
    private let api = NotesApi.shared
    private var favNotes = [Note]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "favCell")
        
        NoteService.shared.noteUpdatedCompletion.append {
            self.setupUI()
        }
        
        setupUI()
    }
    
    
    
    func setupUI() {
        favNotes = NoteService.shared.notes.filter { thisNote in
            thisNote.isFavorites
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFav",
           let vc = segue.destination as? UpdateNoteViewController,
           let indexPath = sender as? IndexPath {
            
            let note = favNotes[indexPath.row]
            vc.note = note
        }
    }
    
}


extension FavorTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favNotes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell",
                                                 for: indexPath) as! CustomTableViewCell
        
        let fav = favNotes[indexPath.row]
        cell.title.text = fav.title
        
        return cell
    }
    
    //    @IBAction func undwinkAction(unwindSegue: UIStoryboardSegue){
    //        print("Unwind srabotal")
    //        let newFav = Category()
    //        newFav.title = titleFavor!
    //        newFav.dateCreate = Date()
    //        //        print(newCategory.dateCreate)
    //        do {
    //            try realm.write{
    //                realm.add(newFav)
    //            }
    //        } catch {
    //            print("Category dont add in realm: \(error)")
    //        }
    //        tableView.reloadData()
    //    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToFav", sender: indexPath)
    }
    
    
    
    //    @IBAction func unwindkUpdateFav(unwindSegue: UIStoryboardSegue){
    //        print("Update Note")
    //        if let indexPath = tableView.indexPathForSelectedRow{
    //            if let fav = fav?[indexPath.row]{
    //                do {
    //                    try realm.write{
    //                        fav.title = titleFav ?? "Заметка"
    //                        fav.text = textFav ?? ""
    //                        fav.dateCreate = Date()
    //                    }
    //                } catch {
    //                    print("Note ne zapisalsya: \(error)")
    //                }
    //            }
    //        }
    //        tableView.reloadData()
    //    }
    
    //    func load() {
    //        favor = realm.objects(Category.self).sorted(byKeyPath: "dateCreate", ascending: false)
    //        tableView.reloadData()
    //        func load(){
    //            fav = selectedfav?.notes.sorted(byKeyPath: "dateCreate", ascending: false)
    //            tableView.reloadData()
    //        }
    //    }
    
    
    //    @IBAction func unwindkAddNote(unwindSegue: UIStoryboardSegue){
    //        print("Note is back")
    //        if let currentCategory = self.selectedfav{
    //            do {
    //                try realm.write{
    //                    let newNote = Note()
    //                    newNote.title = titleFav ?? "Заметка"
    //                    newNote.text = textFav ?? ""
    //                    newNote.dateCreate = Date()
    //                    currentCategory.notes.append(newNote)
    //                }
    //            } catch {
    //                print("Note ne zapisalsya: \(error)")
    //            }
    //        }
    //
    //        tableView.reloadData()
    //    }
    //
}









//extension FavorTableViewController: SwipeTableViewCellDelegate{
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Удалить") { action, indexPath in
//            if let favorit = self.favor?[indexPath.row]{
//                do {
//                    try self.realm.write{
//                        self.realm.delete(favorit.notes)
//                        self.realm.delete(favorit)
//                    }
//                } catch  {
//                    print(error)
//                }
//            }
//            //                tableView.reloadData()
//        }
//
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete-icon")
//
//        return [deleteAction]
//
//    }
//
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }
//
//}

