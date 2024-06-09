//
//  NotesViewModel.swift
//  NotesTesting
//
//  Created by Leonardo Rodríguez González on 09/06/24.
//

import Foundation
import Observation

@Observable
class NotesViewModel {
    
     var notes: [Note]
    
    init(notes: [Note] = []) {
        self.notes = notes
    }
    
    func createNoteWith(title: String, text: String) {
        let note = Note(title: title, text: text, createdAt: Date())
        notes.append(note)
    }
    
    func updateNote(id: UUID, title: String, text: String) {
        if let index = notes.firstIndex(where: { $0.id == id}) {
            let updatedNote = Note(id: id, title: title, text: text, createdAt: notes[index].createdAt)
            notes[index] = updatedNote
        }
    }
    
    func removeNote(id: UUID) {
        notes.removeAll(where: { $0.id == id })
    }
    
}
