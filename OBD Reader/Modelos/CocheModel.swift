//
//  CocheModel.swift
//  OBD Reader
//
//  Created by administrador on 8/6/25.
//

import Foundation
/// Clase CocheModel, que guarda información sobre un vehículo y sus mantenimientos
class CocheModel: Identifiable, ObservableObject, Codable, Hashable {
    var id: UUID
    @Published var marca: String
    @Published var modelo: String
    @Published var matricula: String
    @Published var mantementos: [MantementoModel]

    init() {
        self.id = UUID()
        self.marca = ""
        self.modelo = ""
        self.matricula = ""
        self.mantementos = []
    }
    
    init(id: UUID = UUID(), marca: String, modelo: String, matricula: String, mantementos: [MantementoModel] = []) {
        self.id = id
        self.marca = marca
        self.modelo = modelo
        self.matricula = matricula
        self.mantementos = mantementos
    }

    /// Implementación de funcións para que sexa codeable (codificar / decodificar JSON)
    enum CodingKeys: String, CodingKey {
        case id, marca, modelo, matricula, mantementos
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.marca = try container.decode(String.self, forKey: .marca)
        self.modelo = try container.decode(String.self, forKey: .modelo)
        self.matricula = try container.decode(String.self, forKey: .matricula)
        self.mantementos = try container.decode([MantementoModel].self, forKey: .mantementos)
    }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(marca, forKey: .marca)
        try container.encode(modelo, forKey: .modelo)
        try container.encode(matricula, forKey: .matricula)
        try container.encode(mantementos, forKey: .mantementos)
    }

    /// Implementación para que sexa Hasheable (para a selección do coche en Picker )
    static func == (lhs: CocheModel, rhs: CocheModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func engadirMantemento(_ mantemento: MantementoModel) {
        mantementos.append(mantemento)
    }
}
