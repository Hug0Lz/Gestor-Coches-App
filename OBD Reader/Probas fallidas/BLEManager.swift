////
////  BLEManager.swift
////  OBD Reader
////
////  Created by administrador on 31/5/25.
////
//
//import Foundation
//import SwiftUI
//import CoreBluetooth
//
//class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
//    var myCentral: CBCentralManager!
//    @Published var estaEncendido = false
//    @Published var perifericos = [PerifericoModel]()
//    @Published var idPerifericoConectado: UUID?
//    var perifericoConectado: CBPeripheral?
//    var obdCharacteristic: CBCharacteristic?
//
//    override init() {
//        super.init()
//        myCentral = CBCentralManager(delegate: self, queue: nil)
//    }
//    
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        estaEncendido = central.state == .poweredOn
//        if estaEncendido {
//            iniciarEscaneo()
//        } else {
//            pararEscaneo()
//        }
//    }
//    
//    func centralManager(_ central: CBCentralManager, didDiscover periferico: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
//        let nuevoPeriferico = PerifericoModel(id: periferico.identifier, nombre: periferico.name ?? "Desconocido", rssi: RSSI.intValue)
//        
//        if !perifericos.contains(where: { $0.id == nuevoPeriferico.id }) {
//            DispatchQueue.main.async {
//                self.perifericos.append(nuevoPeriferico)
//            }
//        }
//    }
//    
//    func iniciarEscaneo() {
//        print("Inicia el escaneo")
//        myCentral.scanForPeripherals(withServices: nil, options: nil)
//    }
//    
//    func pararEscaneo() {
//        print("Para el escaneo")
//        myCentral.stopScan()
//    }
//    
//    func conectar(to periferico: PerifericoModel) {
//        guard let cbPeriferico = myCentral.retrievePeripherals(withIdentifiers: [periferico.id]).first else {
//            print("No se ha encontrado el periférico para la conexión")
//            return
//        }
//        
//        idPerifericoConectado = cbPeriferico.identifier
//        cbPeriferico.delegate = self
//        perifericoConectado = cbPeriferico
//        myCentral.connect(cbPeriferico, options: nil)
//    }
//    
//    func desconectarPeriferico() {
//        guard let cbPeriferico = perifericoConectado else {
//            print("No hay periférico conectado para desconectar")
//            return
//        }
//        
//        if cbPeriferico.state == .connected {
//            myCentral.cancelPeripheralConnection(cbPeriferico)
//        }
//        
//        idPerifericoConectado = nil
//        perifericoConectado = nil
//        obdCharacteristic = nil
//    }
//    
//    func centralManager(_ central: CBCentralManager, didConnect periferico: CBPeripheral) {
//        print("✅ Conexión establecida con: \(periferico.name ?? "Desconocido")")
//        perifericoConectado = periferico
//        print("🔄 Periférico asignado correctamente: \(perifericoConectado?.name ?? "No asignado")")
//        periferico.delegate = self
//        periferico.discoverServices(nil)
//    }
//
//    
//    func peripheral(_ periferico: CBPeripheral, didDiscoverServices error: Error?) {
//        if let services = periferico.services {
//            for service in services {
//                print("Servicio descubierto: \(service.uuid)")
//                periferico.discoverCharacteristics(nil, for: service)
//            }
//        }
//    }
//    
//    func peripheral(_ periferico: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        if let characteristics = service.characteristics {
//            for characteristic in characteristics {
//                print("Característica descubierta: \(characteristic.uuid)")
//                
//                if characteristic.uuid == CBUUID(string: "FFF2") {
//                    obdCharacteristic = characteristic
//                    print("✅ Característica OBD identificada: \(characteristic.uuid)")
//                    
//                    if characteristic.properties.contains(.notify) {
//                        periferico.setNotifyValue(true, for: characteristic)
//                        print("📡 Suscrito a notificaciones de FFF2")
//                    }
//                }
//            }
//        }
//    }
//
//
//    
//    func peripheral(_ periferico: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//        guard error == nil else {
//            print("🚨 Error al leer característica \(characteristic.uuid): \(error!.localizedDescription)")
//            return
//        }
//
//        if let value = characteristic.value {
//            let responseString = String(data: value, encoding: .utf8) ?? "❌ No se pudo decodificar la respuesta"
//            print("📡 Respuesta del OBD-II: \(responseString)")
//        }
//    }
//
//
//    
//    func obtenerCaracteristicaOBD() -> CBCharacteristic? {
//        return obdCharacteristic?.uuid == CBUUID(string: "FFF2") ? obdCharacteristic : nil
//    }
//
//}
