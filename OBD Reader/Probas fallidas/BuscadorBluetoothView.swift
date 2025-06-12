////
////  BuscadorBluetoothView.swift
////  OBD Reader
////
////  Created by administrador on 28/5/25.
////
//
//import SwiftUI
//
//struct BuscadorBluetoothView: View {
//    @ObservedObject private var bluetoothScanner = BluetoothManager()
//    @State private var searchText = ""
//    var body: some View {
//        VStack {
//            HStack {
//                // Text field for entering search text
//                TextField("Search", text: $searchText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                // Button for clearing search text
//                Button(action: {
//                    self.searchText = ""
//                }) {
//                    Image(systemName: "xmark.circle.fill")
//                        .foregroundColor(.secondary)
//                }
//                .buttonStyle(PlainButtonStyle())
//                .opacity(searchText == "" ? 0 : 1)
//            }
//            .padding()
//
//            // List of discovered peripherals filtered by search text
//            List(bluetoothScanner.discoveredPeripherals.filter {
//                self.searchText.isEmpty ? true : $0.peripheral.name?.lowercased().contains(self.searchText.lowercased()) == true
//            }, id: \.peripheral.identifier) { discoveredPeripheral in
//                VStack(alignment: .leading) {
//                    Text(discoveredPeripheral.peripheral.name ?? "Dispositivo sin nombre")
//                    Text(discoveredPeripheral.advertisedData)
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
//            }
//
//            // Button for starting or stopping scanning
//            Button(action: {
//                if self.bluetoothScanner.isScanning {
//                    self.bluetoothScanner.stopScan()
//                } else {
//                    self.bluetoothScanner.startScan()
//                }
//            }) {
//                if bluetoothScanner.isScanning {
//                    Text("Stop Scanning")
//                } else {
//                    Text("Scan for Devices")
//                }
//            }
//            // Button looks cooler this way on iOS
//            .padding()
//            .background(bluetoothScanner.isScanning ? Color.red : Color.blue)
//            .foregroundColor(Color.white)
//            .cornerRadius(5.0)
//        }
//    }
//}
//
//
//#Preview {
//    BuscadorBluetoothView()
//}
