import Foundation
import Combine

/// Clase MantementoModel, que garda información sobre un tipo de mantemento realizado a un vehículo.
class MantementoModel: ObservableObject, Identifiable, Codable {
    var id: UUID
    @Published var fechaRegistro: Date
    @Published var proximaNotificacion: Date
    @Published var titulo: String
    @Published var descripcion: String
    @Published var icono: String
    @Published var listaMantementos: [RexistroMantementoModel] {
        didSet {
            updateProximaNotificacion()
        }
    }

    // Para gardar o subscription ao Published de listaMantementos
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.id = UUID()
        self.fechaRegistro = Date()
        self.proximaNotificacion = Date()
        self.titulo = ""
        self.descripcion = ""
        self.icono = "wrench"
        self.listaMantementos = []
        setupBindings()
    }
    
    init(
        id: UUID = UUID(),
        fechaRegistro: Date,
        proximaNotificacion: Date,
        titulo: String,
        descripcion: String,
        icono: String,
        listaMantementos: [RexistroMantementoModel] = []
    ) {
        self.id = id
        self.fechaRegistro = fechaRegistro
        self.proximaNotificacion = proximaNotificacion
        self.titulo = titulo
        self.descripcion = descripcion
        self.icono = icono
        self.listaMantementos = listaMantementos
        setupBindings()
        updateProximaNotificacion()
    }

    /// Configura os bindings para que calquera cambio (append, remove…) en listaMantementos dispare o cálculo.
    private func setupBindings() {
        $listaMantementos
            .sink { [weak self] _ in
                self?.updateProximaNotificacion()
            }
            .store(in: &cancellables)
    }

    /// Calcula a fecha futura máis próxima de entre todolos rexistros
    private func updateProximaNotificacion() {
        let ahora = Date()
        let futuras = listaMantementos
            .map(\.fechaMantemento)
            .filter { $0 > ahora }
        if let proxima = futuras.min() {
            proximaNotificacion = proxima
        } else {
            // Se non hai ningunha data futura, podes deixala en Date() ou nil (se o fas optional)
            proximaNotificacion = ahora
        }
    }

    /// Engade un rexistro e reinicia o cálculo de próxima notificación
    func engadirRexistro(_ rexistro: RexistroMantementoModel) {
        listaMantementos.append(rexistro)
        // O didSet e o publisher de listaMantementos xa chamarán a updateProximaNotificacion()
    }

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case id, fechaRegistro, proximaNotificacion, titulo, descripcion, icono, listaMantementos
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        fechaRegistro = try container.decode(Date.self, forKey: .fechaRegistro)
        proximaNotificacion = try container.decode(Date.self, forKey: .proximaNotificacion)
        titulo = try container.decode(String.self, forKey: .titulo)
        descripcion = try container.decode(String.self, forKey: .descripcion)
        icono = try container.decode(String.self, forKey: .icono)
        listaMantementos = try container.decode([RexistroMantementoModel].self, forKey: .listaMantementos)
        setupBindings()
        updateProximaNotificacion()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(fechaRegistro, forKey: .fechaRegistro)
        try container.encode(proximaNotificacion, forKey: .proximaNotificacion)
        try container.encode(titulo, forKey: .titulo)
        try container.encode(descripcion, forKey: .descripcion)
        try container.encode(icono, forKey: .icono)
        try container.encode(listaMantementos, forKey: .listaMantementos)
    }
}
