//
//  Note.swift
//  NotesTesting
//
//  Created by Leonardo Rodríguez González on 09/06/24.
//

import Foundation
import SwiftData // importar esto en todos los modelos que se podrán persistir con SwiftData

@Model
class Note: Identifiable, Hashable {
    @Attribute(.unique) var identifier: UUID
    var title: String
    var text: String?
    var createdAt: Date
    
    var getText: String {
        // propiedad computada para obtener el contenido de la nota
        text ?? ""
    }
    
    init(identifier: UUID = UUID(), title: String, text: String?, createdAt: Date) {
        self.identifier = identifier
        self.title = title
        self.text = text
        self.createdAt = createdAt
    }
    
}
