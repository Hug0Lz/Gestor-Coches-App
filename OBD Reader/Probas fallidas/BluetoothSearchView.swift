////
////  BluetoothSearchView.swift
////  OBD Reader
////
////  Created by administrador on 3/6/25.
////
//
//import SwiftUI
//
//struct BluetoothSearchView: View {
//    @EnvironmentObject var bleManager: BLEManager
//
//    var body: some View {
//        VStack(spacing: 10) {
//            Text("Lista de dispositivos BLE")
//                .font(.largeTitle)
//                .frame(maxWidth: .infinity, alignment: .center)
//            
//            List(bleManager.perifericos) { periferico in
//                HStack {
//                    Text(periferico.nombre)
//                    Spacer()
//                    Text("RSSI: \(periferico.rssi)")
//                    
//                    Button(action: {
//                        if bleManager.idPerifericoConectado == periferico.id {
//                            bleManager.desconectarPeriferico() // Desconectar si ya está conectado
//                        } else {
//                            bleManager.conectar(to: periferico) // Conectar si no lo está
//                        }
//                    }) {
//                        Text(bleManager.idPerifericoConectado == periferico.id ? "Desconectar" : "Conectarse")
//                            .foregroundColor(bleManager.idPerifericoConectado == periferico.id ? .red : .blue)
//                    }
//                }
//            }
//        }
//        .frame(height: UIScreen.main.bounds.height / 2)
//        
//        Spacer()
//        
//        Text("Estado")
//            .font(.headline)
//        
//        Text(bleManager.estaEncendido ? "Bluetooth encendido" : "La conexión Bluetooth está desactivada")
//            .foregroundColor(bleManager.estaEncendido ? .green : .red)
//        
//        Spacer()
//        
//        VStack(spacing: 25) {
//            Button(action: {
//                bleManager.iniciarEscaneo()
//            }) {
//                Text("Iniciar escaneo")
//            }
//            .buttonStyle(BorderedProminentButtonStyle())
//            
//            if bleManager.idPerifericoConectado != nil {
//                Button(action: {
//                    bleManager.desconectarPeriferico()
//                }) {
//                    Text("Desconectar dispositivo")
//                        .foregroundColor(.red)
//                }
//            }
//        }
//        .padding()
//        
//        Spacer()
//    }
//}
//
//#Preview {
//    BluetoothSearchView()
//}
