//
//  Note.swift
//  NotesTesting
//
//  Created by Leonardo Rodríguez González on 09/06/24.
//

import Foundation

struct Note: Identifiable, Hashable {
    
    let id: UUID
    let title: String
    let text: String?
    let createdAt: Date
    
    var getText: String {
        // propiedad computada para obtener el contenido de la nota
        text ?? ""
    }
    
    init(id: UUID = UUID(), title: String, text: String?, createdAt: Date) {
        self.id = id
        self.title = title
        self.text = text
        self.createdAt = createdAt
    }
    
}
