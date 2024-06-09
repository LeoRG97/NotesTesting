//
//  CreateNoteView.swift
//  NotesTesting
//
//  Created by Leonardo Rodríguez González on 09/06/24.
//

import SwiftUI

struct CreateNoteView: View {
    
    var viewModel: NotesViewModel
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // propiedad "prompt" sirve para que el campo de texto se expanda en vertical si el texto es muy extenso
                    TextField("", text: $title, prompt: Text("*Título"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("*Texto"), axis: .vertical)
                } footer: {
                    Text("* El título es obligatorio")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cerrar")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.createNoteWith(title: title, text: text)
                        dismiss()
                    }) {
                        Text("Crear nota")
                    }
                }
            }
            .navigationTitle("Nueva nota")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    CreateNoteView(viewModel: .init())
}
