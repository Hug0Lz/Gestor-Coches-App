//
//  ContentView.swift
//  OBD Reader
//
//  Created by administrador on 20/5/25.
//


import SwiftUI
import CoreBluetooth

 struct ContentView: View {
//    @StateObject var bleManager = BLEManager()
    @StateObject var cochesViewModel = AlmacenCoches()

    var body: some View {
    TabView {
            Tab {
                OBDView()
            } label: {
                    VStack {
                        Image(systemName: "personalhotspot.circle")
                        Text("OBD")
                    }
                }
        Tab {
            CochesView()
                .environmentObject(cochesViewModel)
        } label: {
                VStack {
                    Image(systemName: "door.garage.closed")
                    Text("Coches")
                }
            }
        Tab {
            MantementosView()
                .environmentObject(cochesViewModel)
        } label: {
                VStack {
                    Image(systemName: "checklist")
                    Text("Mantenimientos")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
