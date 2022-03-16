//
//  NoteModel.swift
//  Notes
//
//  Created by Дмитрий Старков on 13.03.2022.
//

import Foundation
import RealmSwift

class NoteModel:Object {
    @objc dynamic var name = ""
    @objc dynamic var textOfNote = ""
    @objc dynamic var id = ""
    
    convenience init(name: String,textOfNote: String,id: String){
        self.init()
        self.name = name
        self.textOfNote = textOfNote
        self.id = id
    }
}
