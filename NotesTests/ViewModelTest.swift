//
//  ViewModelTest.swift
//  NotesTests
//
//  Created by Leonardo Rodríguez González on 23/06/24.
//
// MARK: UNIT TESTS

import XCTest
@testable import NotesTesting

final class ViewModelTest: XCTestCase {
    
    var viewModel: NotesViewModel!

    override func setUpWithError() throws {
        // MARK: inicializar view model con las instancias de los mocks (que no se te olvide este paso)
        viewModel = NotesViewModel(createNotesUseCase: CreateNoteUseCaseMock(), fetchNotesUseCase: FetchAllNotesUseCaseMock(), updateNoteUseCase: UpdateNoteUseCaseMock(), deleteNoteUseCase: DeleteNoteUseCaseMock())
    }

    override func tearDownWithError() throws {
        // vaciar el arrak de notas después de terminar cada prueba
        mockDatabase = []
    }
    
    func testCreateNote() {
        let title = "Title"
        let text = "Content"
        
        viewModel.createNoteWith(title: title, text: text)
        
        XCTAssertEqual(viewModel.notes.count, 1) // comprobar que el array de "notes" ahora contiene 1 nota
        XCTAssertEqual(viewModel.notes.first?.title, title) // comprobar que la nueva nota tenga el título especificado
        XCTAssertEqual(viewModel.notes.first?.text, text) // comprobar que la nueva nota tenga el texto especificado
    }
    
    func testCreateThreeNotes() {
        
        let title = "Title 1"
        let text = "Content 1"
        
        let title2 = "Title 2"
        let text2 = "Content 2"
        
        let title3 = "Title 3"
        let text3 = "Content 3"
        
        viewModel.createNoteWith(title: title, text: text)
        viewModel.createNoteWith(title: title2, text: text2)
        viewModel.createNoteWith(title: title3, text: text3)
        
        XCTAssertEqual(viewModel.notes.count, 3)
        XCTAssertEqual(viewModel.notes.first?.title, title)
        XCTAssertEqual(viewModel.notes.first?.text, text)
        
        XCTAssertEqual(viewModel.notes[1].title, title2)
        XCTAssertEqual(viewModel.notes[1].text, text2)
        
        XCTAssertEqual(viewModel.notes[2].title, title3)
        XCTAssertEqual(viewModel.notes[2].text, text3)
    }
    
    
    func testUpdateNote() {
        
        let title = "Title"
        let text = "Content"

        viewModel.createNoteWith(title: title, text: text)
        
        let newTitle = "New Title"
        let newText = "New Text"
       
        if let identifier = viewModel.notes.first?.identifier {
            viewModel.updateNote(identifier: identifier, title: newTitle, text: newText)
            
            XCTAssertEqual(viewModel.notes.first?.title, newTitle)
            XCTAssertEqual(viewModel.notes.first?.text, newText)
            
        } else {
            XCTFail("No se encontró la nota")
        }
        
    }
    
    func testRemoveNote() {
        
        let title = "Title"
        let text = "Content"

        viewModel.createNoteWith(title: title, text: text)
        
        if let identifier = viewModel.notes.first?.identifier {
            viewModel.removeNote(identifier: identifier)
            XCTAssertTrue(viewModel.notes.isEmpty) // verifica si una expresión devuelve "true"
        } else {
            XCTFail("No se encontró la nota")
        }
        
    }

}
