//
//  CochesViewModel.swift
//  OBD Reader
//
//  Created by administrador on 9/6/25.
//
import Foundation
//
//@MainActor
//class CochesViewModel: ObservableObject {
//    @Published var coches: [CocheModel] = []
//
//    init() {
//        Task {
//             cargarCoches()
//        }
//    }
//
//    // Carga coches desde almacenamiento JSON
//    func cargarCoches() {
//        coches = CochesStorage.shared.cargar()
//        print("🚗 Coches cargados: \(coches.count)")
//    }
//
//    // Añade un coche, guarda la lista
//    func agregar(_ coche: CocheModel) {
//        coches.append(coche)
//        guardar()
//    }
//
//    // Actualiza un coche existente por id, guarda la lista
//    func actualizar(_ coche: CocheModel) {
//        if let index = coches.firstIndex(where: { $0.id == coche.id }) {
//            coches[index] = coche
//            guardar()
//        }
//    }
//
//    // Elimina coches en los índices dados, guarda la lista
//    func eliminar(at offsets: IndexSet) {
//        coches.remove(atOffsets: offsets)
//        guardar()
//    }
//
//    // Guarda el array completo
//    func guardar() {
//        Task {
//            await CochesStorage.shared.guardar(coches)
//        }
//    }
//}


