//
//  Mocks.swift
//  NotesTests
//
//  Created by Leonardo Rodríguez González on 09/07/24.
//

import Foundation
@testable import NotesTesting

// simulación de la base de datos
var mockDatabase: [Note] = []

// mock para simular el caso de uso para crear una nota
struct CreateNoteUseCaseMock: CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws {
        let note = Note(title: title, text: text, createdAt: .now)
        mockDatabase.append(note)
    }
}

// mock para simular el caso de uso para obtener las notas
struct FetchAllNotesUseCaseMock: FetchAllNotesProtocol {
    func fetchAll() throws -> [NotesTesting.Note] {
        return mockDatabase
    }
}

// mock para simular el caso de uso para actualizar una nota
struct UpdateNoteUseCaseMock: UpdateNoteProtocol {
    func updateNoteWith(identifier: UUID, title: String, text: String?) throws {
        if let index = mockDatabase.firstIndex(where: {$0.identifier == identifier}) {
            mockDatabase[index].title = title
            mockDatabase[index].text = text
        }
    }
}

// mock para simular el caso de uso para eliminar una nota
struct DeleteNoteUseCaseMock: DeleteNoteProtocol {
    func removeNote(identifier: UUID) throws {
        if let index = mockDatabase.firstIndex(where: {$0.identifier == identifier}) {
            mockDatabase.remove(at: index)
        }
    }
}
