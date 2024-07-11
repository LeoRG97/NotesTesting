//
//  DeleteNoteUseCase.swift
//  NotesTesting
//
//  Created by Leonardo Rodríguez González on 09/07/24.
//

import Foundation

protocol DeleteNoteProtocol {
    func removeNote(identifier: UUID) throws
}

struct DeleteNoteUseCase: DeleteNoteProtocol {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func removeNote(identifier: UUID) throws {
        try notesDatabase.remove(identifier: identifier)
    }
}
