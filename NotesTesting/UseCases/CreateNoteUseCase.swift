//
//  CreateNoteUseCase.swift
//  NotesTesting
//
//  Created by Leonardo Rodríguez González on 29/06/24.
//
// MARK: Caso de uso para crear una nota en la base de datos

import Foundation

// ESTE PROTOCOLO nos permite crear el mockup de este caso de uso
// Los protocolos son reglas que definen qué es lo que se necesita, pero no cómo lograrlo
protocol CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws
}

struct CreateNoteUseCase: CreateNoteProtocol {
    
    // inyección de dependencias (basarse en abstracciones en lugar de implementaciones concretas)
    private var notesDatabase: NotesDatabaseProtocol
    
    // inicializar el caso de uso con la instancia singleton de la base de datos
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func createNoteWith(title: String, text: String) throws {
        let note = Note(identifier: .init(), title: title, text: text, createdAt: .now)
        try notesDatabase.insert(note: note)
    }
    
}
