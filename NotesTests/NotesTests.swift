//
//  NotesTests.swift
//  NotesTests
//
//  Created by Leonardo Rodríguez González on 23/06/24.
//

import XCTest // framework para clases y funciones de testing
@testable import NotesTesting // importar el package de nuestra app para usar las clases y objetos de la misma

final class NoteTest: XCTestCase {
    
    func testNoteInitialization() {
        // Given or Arrange
        let title = "test title"
        let text = "content"
        let date = Date()
        
        // When or Act
        let note = Note(title: title, text: text, createdAt: date)
        
        // Then or Assert
        XCTAssertEqual(note.title, title, "Title should be equal to test title")
        XCTAssertEqual(note.text, text)
        XCTAssertEqual(note.createdAt, date)
    }
    
    func testNoteEmptyText() {
        let title = "Test title"
        let date = Date()
        
        let note = Note(title: title, text: nil, createdAt: date)
        
        XCTAssertEqual(note.getText, "")
    }

}
