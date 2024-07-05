//
//  FetchNotesUseCase.swift
//  NotesTesting
//
//  Created by Leonardo Rodríguez González on 29/06/24.
//
// MARK: Caso de uso para obtener todas las notas de la base de datos

import Foundation

protocol FetchAllNotesProtocol {
    func fetchAll() throws -> [Note]
}

struct FetchNotesUseCase: FetchAllNotesProtocol {
    
    private var notesDatabase: NotesDatabaseProtocol
    
    // inicializar el caso de uso con la instancia singleton de la base de datos
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func fetchAll() throws -> [Note] {
        try notesDatabase.fetchAll()
    }
    
}
