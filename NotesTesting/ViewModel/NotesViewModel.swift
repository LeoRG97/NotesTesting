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
    var createNotesUseCase: CreateNoteProtocol
    var fetchNotesUseCase: FetchAllNotesProtocol
    
    init(notes: [Note] = [], createNotesUseCase: CreateNoteProtocol = CreateNoteUseCase(), fetchNotesUseCase: FetchAllNotesProtocol = FetchNotesUseCase()) {
        self.notes = notes
        self.createNotesUseCase = createNotesUseCase
        self.fetchNotesUseCase = fetchNotesUseCase
        fetchAllNotes()
    }
    
    func createNoteWith(title: String, text: String) {
        do {
            try createNotesUseCase.createNoteWith(title: title, text: text)
            fetchAllNotes() // actualiza la lista de notas
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        // let note = Note(title: title, text: text, createdAt: Date())
        //notes.append(note)
    }
    
    func fetchAllNotes() {
        do {
            self.notes = try fetchNotesUseCase.fetchAll()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func updateNote(identifier: UUID, title: String, text: String) {
        if let index = notes.firstIndex(where: { $0.identifier == identifier}) {
            let updatedNote = Note(identifier: identifier, title: title, text: text, createdAt: notes[index].createdAt)
            notes[index] = updatedNote
        }
    }
    
    func removeNote(identifier: UUID) {
        notes.removeAll(where: { $0.identifier == identifier })
    }
    
}
