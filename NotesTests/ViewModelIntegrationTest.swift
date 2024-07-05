//
//  ViewModelIntegrationTest.swift
//  NotesTests
//
//  Created by Leonardo Rodríguez González on 29/06/24.
//

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


}
