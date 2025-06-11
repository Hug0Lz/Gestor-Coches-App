//
//  GestionarCochesView.swift
//  OBD Reader
//
//  Created by administrador on 8/6/25.
//

import SwiftUI

struct GestionarCochesView: View {
   @Binding  var coches:[CocheModel]
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Listado de coches")) {
                    ForEach($coches) { $coche in
                        Text("Hola")
                        NavigationLink(destination: DetalleCocheView(coche: coche)) {
                            HStack {
                                Text("\(coche.marca) \(coche.modelo)")
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Gestionar coches")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "car")
                        Text("Citroen Xsara")
                            .font(.headline)
                    }
                }
            }
        }
    }

}


//#Preview {
//    GestionarCochesView(coches: [CocheModel(marca: "Citroen", modelo: "Xsara", matricula: "3482BCB")])
//}
