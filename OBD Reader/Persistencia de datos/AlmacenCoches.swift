//
//  SwiftUIView.swift
//  OBD Reader
//
//  Created by administrador on 9/6/25.
//

import SwiftUI
/// Clase AlmacenCoches, que lee o Json coches.json para obter a información guardada sobre os mesmos
final class AlmacenCoches: ObservableObject {
    @Published var coches: [CocheModel] = []
    
    init() {
        if let data = abrirArquivo(nomeArquivo: "coches.json") {
            coches = procesarJSON(arquivo: data)
        } else {
            print("⚠️ No se pudo cargar coches.json")
            coches = []
        }
    }
}
