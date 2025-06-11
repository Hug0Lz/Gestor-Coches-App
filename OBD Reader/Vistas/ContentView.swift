//
//  ContentView.swift
//  OBD Reader
//
//  Created by administrador on 20/5/25.
//


import SwiftUI
import CoreBluetooth

struct ContentView: View {
    @StateObject var bleManager = BLEManager()
    @ObservedObject var viewModel = ViewModel()
//    @State private var coches: [CocheModel] = [
//        CocheModel(marca: "Citroen", modelo: "Xantia", matricula: "1234ABC"),
//        CocheModel(marca: "Renault", modelo: "Clio", matricula: "5678DEF")
//    ]
    @StateObject var cochesViewModel = AlmacenCoches()


    var body: some View {
    TabView {
            Tab {
//                ELM327InteractionView()
//                    .environmentObject(bleManager)
                VStack(spacing: 20) {
                           Text("Estado de conexión: \(viewModel.connectionState)")
                               .font(.headline)

                           Button("Conectar") {
                               Task {
                                   await viewModel.startConnection()
                               }
                           }
                           .buttonStyle(.borderedProminent)

                           Button("Desconectar") {
                               viewModel.stopConnection()
                           }
                           .buttonStyle(.bordered)
                    
                    Button("Ver RPM") {
//                        viewModel.enviarComando(.mode1(.rpm)) // Reinicia el adaptador OBD-II
                    }
                    .buttonStyle(.bordered)

        
                    
                       }
                       .padding()
                
              
            } label: {
                    VStack {
                        Image(systemName: "personalhotspot.circle")
                        Text("OBD")
                    }
                }
        Tab {
            MantementosView()
          
        } label: {
            
                VStack {
                    Image(systemName: "checklist")
                    Text("Mantenimientos")
                }
            }
        Tab {
            
//            HomeView()
            
         
                  List {
                      ForEach(cochesViewModel.coches) { coche in
                          VStack(alignment: .leading) {
                              Text(coche.marca)
                                  .font(.headline)
                              Text("\(coche.modelo) - \(coche.matricula)")
                                  .font(.subheadline)
                                  .foregroundColor(.gray)
                          }
                      }
                  }
                  .navigationTitle("Lista de Coches")
              
          
          
        } label: {
            
                VStack {
                    Image(systemName: "house.circle")
                    Text("Inicio")
                }
            }
        Tab {
//            BluetoothSearchView()
//                .environmentObject(bleManager)

        } label: {
            VStack{
                Image(systemName: "wifi")
                Text("BLE Test")
            }
        }
            
        }
    }
}

#Preview {
    ContentView()
}
