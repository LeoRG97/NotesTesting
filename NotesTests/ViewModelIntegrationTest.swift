//
//  ViewModelIntegrationTest.swift
//  NotesTests
//
//  Created by Leonardo Rodríguez González on 29/06/24.
//
// MARK: INTEGRATION TESTS

import XCTest
@testable import NotesTesting

@MainActor // especificar que los tests se ejecutarán en el hilo principal (por SwiftData)
final class ViewModelIntegrationTest: XCTestCase {
    
    var sut: NotesViewModel! // System Under Test (terminología para identificar el objeto a testear)

    override func setUpWithError() throws {
        let database = NotesDatabase.shared
        database.container = NotesDatabase.setupContainer(inMemory: true)
        
        let createNoteUseCase = CreateNoteUseCase(notesDatabase: database)
        let fetchNotesUseCase = FetchNotesUseCase(notesDatabase: database)
        
        sut = NotesViewModel(createNotesUseCase: createNoteUseCase, fetchNotesUseCase: fetchNotesUseCase)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateNote() {
        // Given
        sut.createNoteWith(title: "Hello", text: "World")
        
        // When
        let note = sut.notes.first
        
        // Then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "Hello")
        XCTAssertEqual(note?.text, "World")
        XCTAssertEqual(sut.notes.count, 1, "Debería haber una nota en la base de datos")
    }
    
    func testCreateTwoNotes() {
        // Given
        sut.createNoteWith(title: "Hello", text: "World")
        sut.createNoteWith(title: "Hello 2", text: "World 2")
        
        // When
        let note = sut.notes.first
        let secondNote = sut.notes.last
        
        // Then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "Hello")
        XCTAssertEqual(note?.text, "World")
        XCTAssertNotNil(secondNote)
        XCTAssertEqual(secondNote?.title, "Hello 2")
        XCTAssertEqual(secondNote?.text, "World 2")
        XCTAssertEqual(sut.notes.count, 2, "Debería haber dos notas en la base de datos")
    }
    
    func testFetchAllNotes() {
        // Given
        sut.createNoteWith(title: "Hello", text: "World")
        sut.createNoteWith(title: "Hello 2", text: "World 2")
        
        // When
        let note = sut.notes[0]
        let secondNote = sut.notes[1]
        
        // Then
        XCTAssertEqual(sut.notes.count, 2, "Debería haber dos notas en la base de datos")
        XCTAssertEqual(note.title, "Hello")
        XCTAssertEqual(note.text, "World")
        XCTAssertEqual(secondNote.title, "Hello 2")
        XCTAssertEqual(secondNote.text, "World 2")
        
    }
    
    func testUpdateNote() {
        // Given
        sut.createNoteWith(title: "Hello", text: "World")
        guard let note = sut.notes.first else {
            XCTFail()
            return
        }
        
        // When
        sut.updateNote(identifier: note.identifier, title: "Goodbye", text: "Friends")
        
        // Then
        XCTAssertTrue(sut.notes.count == 1)
        XCTAssertEqual(sut.notes[0].title, "Goodbye")
        XCTAssertEqual(sut.notes[0].text, "Friends")
    }
    
    func testDeleteNote() {
        // Given
        sut.createNoteWith(title: "Nota 1", text: "Texto 1")
        sut.createNoteWith(title: "Nota 2", text: "Texto 2")
        sut.createNoteWith(title: "Nota 3", text: "Texto 3")
        
        // When
        guard let note = sut.notes.last else {
            XCTFail()
            return
        }
        sut.removeNote(identifier: note.identifier)
        
        // Then
        XCTAssertTrue(sut.notes.count == 2, "Debería haber 2 notas en la base de datos")
    }
    
    func testDeleteNoteShouldThrowError() {
        // Given
        
        // When
        sut.removeNote(identifier: UUID())
        
        // Then
        XCTAssertTrue(sut.notes.count == 0, "Debería haber 0 notas en la base de datos")
        XCTAssertNotNil(sut.databaseError)
        XCTAssertEqual(sut.databaseError, .errorDelete)
    }


}
