//
//  NotesDatabase.swift
//  NotesTesting
//
//  Created by Leonardo Rodríguez González on 23/06/24.
//
// MARK: Base de datos para almacenar las notas (usando SwiftData)

import Foundation
import SwiftData

enum DatabaseError: Error {
    case errorInsert
    case errorFetch
    case errorUpdate
    case errorDelete
}

protocol NotesDatabaseProtocol {
    func insert(note: Note) throws
    func fetchAll() throws -> [Note]
    func update(identifier: UUID, title: String, text: String?) throws
    func remove(identifier: UUID) throws
}

class NotesDatabase: NotesDatabaseProtocol {
    static let shared: NotesDatabase = NotesDatabase() // singleton instance
    
    @MainActor
    var container: ModelContainer = setupContainer(inMemory: false)
    
    init() {}
    
    // para crear la base de datos de SwiftData en memoria o en disco
    @MainActor static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: Note.self, configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            print("Error \(error.localizedDescription)")
            fatalError("Database can't be created")
        }
    }
    
    @MainActor
    func insert(note: Note) throws {
        container.mainContext.insert(note)
        do {
            try container.mainContext.save()
        } catch {
            print("Error \(error.localizedDescription)")
            throw DatabaseError.errorInsert
        }
    }
    
    @MainActor
    func fetchAll() throws -> [Note] {
        // obtiene todas las notas de la base de datos
        let fetchDescriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor<Note>(\.createdAt)])
        do {
            return try container.mainContext.fetch(fetchDescriptor)
        } catch {
            print("Error \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }
    
    @MainActor
    func update(identifier: UUID, title: String, text: String?) throws {
        let notePredicate = #Predicate<Note> {
            $0.identifier == identifier
        }
        
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let updateNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }
            
            updateNote.title = title
            updateNote.text = text
            
            try container.mainContext.save()
        } catch let error {
            print("Error actualizando información")
            throw DatabaseError.errorUpdate
        }
    }
    
    @MainActor
    func remove(identifier: UUID) throws {
        let notePredicate = #Predicate<Note> {
            $0.identifier == identifier
        }
        
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let deleteNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }
        
            container.mainContext.delete(deleteNote)
            try container.mainContext.save()
        } catch let error {
            print("Error eliminando la nota")
            throw DatabaseError.errorDelete
        }
    }

}
