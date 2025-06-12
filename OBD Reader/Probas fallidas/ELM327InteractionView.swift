////
////  ELM327InteractionView.swift
////  OBD Reader
////
////  Created by administrador on 4/6/25.
////
//
//import SwiftUI
//import CoreBluetooth
//
//struct ELM327InteractionView: View {
//    @EnvironmentObject var bleManager: BLEManager
//    @State private var conectadoAlVehiculo = false
//    @State private var datosOBD: [String: String] = [:]
//    @State private var errorConexion: String?
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Interacción con OBD-II")
//                .font(.largeTitle)
//            
//            Text(conectadoAlVehiculo ? "Conectado al vehículo" : "Desconectado")
//                .foregroundColor(conectadoAlVehiculo ? .green : .red)
//                .bold()
//
//            // Botón para conectar al OBD-II
//            Button(action: conectarOBD) {
//                Text(conectadoAlVehiculo ? "Desconectar" : "Conectar al vehículo")
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(conectadoAlVehiculo ? Color.red : Color.blue)
//                    .cornerRadius(10)
//            }
//
//            // Mostrar datos del vehículo en tiempo real
//            if conectadoAlVehiculo {
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Datos del vehículo:")
//                        .font(.headline)
//                    
//                    ForEach(datosOBD.keys.sorted(), id: \.self) { key in
//                        HStack {
//                            Text("\(key):")
//                                .bold()
//                            Spacer()
//                            Text(datosOBD[key] ?? "--")
//                        }
//                    }
//                }
//                .padding()
//            }
//
//            if let error = errorConexion {
//                Text("Error: \(error)")
//                    .foregroundColor(.red)
//            }
//        }
//        .padding()
//    }
//
//    func conectarOBD() {
//        guard let periferico = bleManager.perifericoConectado else {
//            errorConexion = "🚨 Error: No hay un dispositivo asignado en BLEManager"
//            print("🚨 Error: No hay un dispositivo asignado en BLEManager")
//            return
//        }
//        
//        print("✅ Periférico encontrado en BLEManager: \(periferico.name ?? "Desconocido")")
//        enviarComandoOBD("ATZ\r")
//        enviarComandoOBD("ATE0\r") // Desactiva eco en la respuesta
//        enviarComandoOBD("ATSP0\r") // Establece protocolo automático
//        enviarComandoOBD("0100\r") // Solicita datos OBD-II disponibles
//
//        guard let characteristic = bleManager.obtenerCaracteristicaOBD() else {
//            print("🚨 Característica OBD no disponible")
//            return
//        }
//        periferico.readValue(for: characteristic)
//        print("📡 Intentando leer valores de la característica FFF2 después de enviar comandos...")
//
//    }
//
//
//    func enviarComandoOBD(_ comando: String) {
//        guard let periferico = bleManager.perifericoConectado,
//              let characteristic = bleManager.obtenerCaracteristicaOBD() else {
//            errorConexion = "No se encontró una característica válida para enviar comandos."
//            print("🚨 Error: Característica OBD no disponible.")
//            return
//        }
//
//        print("✅ Característica usada para enviar comando: \(characteristic.uuid)")
//
//        let data = comando.data(using: .utf8)!
//        periferico.writeValue(data, for: characteristic, type: .withResponse)
//        print("✅ Comando enviado correctamente: \(comando)")
//    }
//
//    func procesarRespuestaOBD(_ respuesta: String) {
//        DispatchQueue.main.async {
//            self.datosOBD["Última respuesta"] = respuesta.trimmingCharacters(in: .whitespacesAndNewlines)
//        }
//    }
//}
//
//
//#Preview {
//    ELM327InteractionView()
//}
