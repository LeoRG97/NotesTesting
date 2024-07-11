//
//  UpdateNoteUseCase.swift
//  NotesTests
//
//  Created by Leonardo Rodríguez González on 09/07/24.
//

import Foundation

protocol UpdateNoteProtocol {
    func updateNoteWith(identifier: UUID, title: String, text: String?) throws
}

struct UpdateNoteUseCase: UpdateNoteProtocol {
    
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func updateNoteWith(identifier: UUID, title: String, text: String?) throws {
        try notesDatabase.update(identifier: identifier, title: title, text: text)
    }
    
}
