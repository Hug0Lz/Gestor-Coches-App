//
//  DetalleRegistroMantementoModel.swift
//  OBD Reader
//
//  Created by administrador on 9/6/25.
//

import Foundation
/// Clase RexistroMantementoModel, que garda información dunha iteración concreta do mantemento
class RexistroMantementoModel: Identifiable, Codable, ObservableObject {
    @Published var id: UUID
    @Published var fechaMantemento: Date
    @Published var anotaciones: String

    init(id: UUID = UUID(), fechaMantemento: Date, anotaciones: String) {
        self.id = id
        self.fechaMantemento = fechaMantemento
        self.anotaciones = anotaciones
    }
    
    /// Implementación de funcións para que sexa codeable (codificar / decodificar JSON)
    enum CodingKeys: String, CodingKey {
        case id, fechaMantemento, anotaciones
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        fechaMantemento = try container.decode(Date.self, forKey: .fechaMantemento)
        anotaciones = try container.decode(String.self, forKey: .anotaciones)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(fechaMantemento, forKey: .fechaMantemento)
        try container.encode(anotaciones, forKey: .anotaciones)
    }
}


