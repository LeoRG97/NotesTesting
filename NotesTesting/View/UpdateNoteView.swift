//
//  UpdateNoteView.swift
//  NotesTesting
//
//  Created by Leonardo Rodríguez González on 09/06/24.
//

import SwiftUI

struct UpdateNoteView: View {
    
    // estas cuatro propiedades se inicializan desde la pantalla "ContentView" (sí, los states también se pueden inicializar como parámetros
    var viewModel: NotesViewModel
    let id: UUID
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                Section {
                    // propiedad "prompt" sirve para que el campo de texto se expanda en vertical si el texto es muy extenso
                    TextField("", text: $title, prompt: Text("*Título"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("*Texto"), axis: .vertical)
                } footer: {
                    Text("* El título es obligatorio")
                }
            }
            Button(action: {
                viewModel.removeNote(id: id)
                dismiss()
            }) {
                Text("Eliminar nota")
                    .foregroundStyle(.gray)
                    .underline()
            }
            .buttonStyle(BorderedButtonStyle())
            Spacer()

        }
        .background(Color(uiColor: .systemBackground))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.updateNote(id: id, title: title, text: text)
                    dismiss()
                }) {
                    Text("Guardar nota")
                }
            }
        }
        .navigationTitle("Modificar nota")
    }
}

#Preview {
    // agregar NavigationStack para ver los elementos visuales de la barra de navegación
    NavigationStack {
        UpdateNoteView(viewModel: .init(), id: .init(), title: "Hola mundo", text: "¿cómo estás?") // .init = UUID()
    }
  
}
