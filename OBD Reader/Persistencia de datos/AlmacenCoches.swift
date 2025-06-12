//
//  SwiftUIView.swift
//  OBD Reader
//
//  Created by administrador on 9/6/25.
//

import Foundation
import SwiftUI

final class AlmacenCoches: ObservableObject {
    @Published var coches: [CocheModel] = [] {
        didSet {
            saveCoches()    // cada vez que coches cambie, grabamos
        }
    }

    /// URL del fichero en Documentos donde guardamos los datos
    private var fileURL: URL = {
        let fm = FileManager.default
        let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent("coches.json")
    }()

    init() {
        loadCoches()
    }

    /// Carga los coches desde Documentos; si no existe, lo trae del bundle y lo copia.
    private func loadCoches() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        if FileManager.default.fileExists(atPath: fileURL.path) {
            // 1) Si ya hemos guardado antes, leemos del sandbox
            do {
                let data = try Data(contentsOf: fileURL)
                coches = try decoder.decode([CocheModel].self, from: data)
            } catch {
                print("❌ Error al leer coches.json de Documentos: \(error)")
                coches = []
            }
        } else {
            // 2) Primera ejecución: cargo el original del bundle y lo copio a Documentos
            guard let bundleURL = Bundle.main.url(forResource: "coches", withExtension: "json") else {
                print("❌ coches.json no está en el bundle")
                coches = []
                return
            }
            do {
                let data = try Data(contentsOf: bundleURL)
                coches = try decoder.decode([CocheModel].self, from: data)
                // Copiamos ese JSON inicial al sandbox para futuras lecturas/escrituras
                try data.write(to: fileURL)
            } catch {
                print("❌ Error al copiar coches.json al sandbox: \(error)")
                coches = []
            }
        }
    }

    /// Codifica y escribe el array `coches` en el sandbox
    private func saveCoches() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        do {
            let data = try encoder.encode(coches)
            try data.write(to: fileURL, options: [.atomic])
            // print("💾 Guardados coches en \(fileURL)")
        } catch {
            print("❌ Error al guardar coches.json: \(error)")
        }
    }
}

