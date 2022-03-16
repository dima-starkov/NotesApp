//
//  RealmManager.swift
//  Notes
//
//  Created by Дмитрий Старков on 13.03.2022.
//


import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject( _ note: NoteModel) {
        try! realm.write({
            realm.add(note)
        })
    }
    
    static func deleteObject( _ note: NoteModel){
        try! realm.write({
            realm.delete(note)
        })
    }
    
    static func updateObject(_ note: NoteModel,name: String,textOfNote: String) {
        try! realm.write({
            note.name = name
            note.textOfNote = textOfNote
        })
    }
    
}
