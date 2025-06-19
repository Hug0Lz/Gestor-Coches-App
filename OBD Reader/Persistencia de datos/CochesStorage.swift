////
////  CochesStorage.swift
////  OBD Reader
////
////  Created by administrador on 9/6/25.
////
//
//import Foundation
//
//class CochesStorage {
//    static let shared = CochesStorage()
//    private let fileName = "coches.json"
//
//    private var fileURL: URL {
//        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        return folder.appendingPathComponent(fileName)
//    }
//
//    func guardar(_ coches: [CocheModel]) {
//        do {
//            let data = try JSONEncoder().encode(coches)
//            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
//        } catch {
//            print("❌ Error al guardar coches: \(error)")
//        }
//    }
//
//    func cargar() -> [CocheModel] {
//        do {
//            if FileManager.default.fileExists(atPath: fileURL.path) {
//                // Leer de Documents
//                let data = try Data(contentsOf: fileURL)
//                return try JSONDecoder().decode([CocheModel].self, from: data)
//            } else {
//                // Leer JSON de ejemplo del bundle
//                if let bundleURL = Bundle.main.url(forResource: "coches", withExtension: "json") {
//                    let data = try Data(contentsOf: bundleURL)
//                    return try JSONDecoder().decode([CocheModel].self, from: data)
//                } else {
//                    print("⚠️ No se encontró coches.json en el bundle")
//                    return []
//                }
//            }
//        } catch {
//            print("⚠️ Error al cargar coches: \(error)")
//            return []
//        }
//    }
//
//}
