import Foundation
/// Clase MantementoModel, que garda información sobre un tipo de mantemento realizado a un vehículo. 
class MantementoModel: ObservableObject, Identifiable, Codable {
    var id: UUID
    @Published var fechaRegistro: Date
    @Published var proximaNotificacion: Date
    @Published var titulo: String
    @Published var descripcion: String
    @Published var icono: String
//    @Published var fotos: [String]
    @Published var listaMantementos: [RexistroMantementoModel]

    init(
        id: UUID = UUID(),
        fechaRegistro: Date,
        proximaNotificacion: Date,
        titulo: String,
        descripcion: String,
        icono: String,
//        fotos: [String] = [],
        listaMantementos: [RexistroMantementoModel] = []
    ) {
        self.id = id
        self.fechaRegistro = fechaRegistro
        self.proximaNotificacion = proximaNotificacion
        self.titulo = titulo
        self.descripcion = descripcion
        self.icono = icono
//        self.fotos = fotos
        self.listaMantementos = listaMantementos
    }

    /// Implementación de funcións para que sexa codeable (codificar / decodificar JSON)
    enum CodingKeys: String, CodingKey {
        case id, fechaRegistro, proximaNotificacion, titulo, descripcion, icono, fotos, listaMantementos
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        fechaRegistro = try container.decode(Date.self, forKey: .fechaRegistro)
        proximaNotificacion = try container.decode(Date.self, forKey: .proximaNotificacion)
        titulo = try container.decode(String.self, forKey: .titulo)
        descripcion = try container.decode(String.self, forKey: .descripcion)
        icono = try container.decode(String.self, forKey: .icono)
//        fotos = try container.decode([String].self, forKey: .fotos)
        listaMantementos = try container.decode([RexistroMantementoModel].self, forKey: .listaMantementos)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(fechaRegistro, forKey: .fechaRegistro)
        try container.encode(proximaNotificacion, forKey: .proximaNotificacion)
        try container.encode(titulo, forKey: .titulo)
        try container.encode(descripcion, forKey: .descripcion)
        try container.encode(icono, forKey: .icono)
//        try container.encode(fotos, forKey: .fotos)
        try container.encode(listaMantementos, forKey: .listaMantementos)
    }
    
    func engadirRexistro(_ rexistro: RexistroMantementoModel) {
        listaMantementos.append(rexistro)
    }
}
