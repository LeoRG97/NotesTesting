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
    var databaseError: DatabaseError?
    
    var createNotesUseCase: CreateNoteProtocol
    var fetchNotesUseCase: FetchAllNotesProtocol
    var updateNoteUseCase: UpdateNoteProtocol
    var deleteNoteUseCase: DeleteNoteProtocol
    
    init(notes: [Note] = [], createNotesUseCase: CreateNoteProtocol = CreateNoteUseCase(), fetchNotesUseCase: FetchAllNotesProtocol = FetchNotesUseCase(), updateNoteUseCase: UpdateNoteProtocol = UpdateNoteUseCase(), deleteNoteUseCase: DeleteNoteProtocol = DeleteNoteUseCase()) {
        self.notes = notes
        self.createNotesUseCase = createNotesUseCase
        self.fetchNotesUseCase = fetchNotesUseCase
        self.updateNoteUseCase = updateNoteUseCase
        self.deleteNoteUseCase = deleteNoteUseCase
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
        do {
            try updateNoteUseCase.updateNoteWith(identifier: identifier, title: title, text: text)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func removeNote(identifier: UUID) {
        do {
            try deleteNoteUseCase.removeNote(identifier: identifier)
            fetchAllNotes()
        } catch let error as DatabaseError {
            print("Error: \(error.localizedDescription)")
            databaseError = error
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
