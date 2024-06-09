//
//  ContentView.swift
//  NotesTesting
//
//  Created by Leonardo Rodríguez González on 09/06/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var viewModel: NotesViewModel = .init()
    @State var showCreateNote: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { item in
                    NavigationLink(value: item) {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .foregroundStyle(.primary)
                            Text(item.getText)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button(action: {
                        showCreateNote.toggle()
                    }) {
                        Label("Crear nota", systemImage: "square.and.pencil")
                            .labelStyle(TitleAndIconLabelStyle())
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .tint(.blue)
                    .bold()
                }
            }
            .navigationTitle("Notas")
            .navigationDestination(for: Note.self, destination: { note in
                UpdateNoteView(viewModel: viewModel, id: note.id, title: note.title, text: note.getText)
            })
            .fullScreenCover(isPresented: $showCreateNote, content: {
                // similar al modal, pero cubre toda la pantalla y sin efecto de profundidad
                CreateNoteView(viewModel: viewModel)
            })
        }
    }
}

#Preview {
    ContentView(viewModel: .init(notes: []))
    
}
