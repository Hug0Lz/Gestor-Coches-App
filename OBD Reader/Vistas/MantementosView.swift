//
//  MantenimientosView.swift
//  OBD Reader
//
//  Created by administrador on 4/6/25.
//

import SwiftUI

struct MantementosView: View {
    @StateObject var almacenCoches = AlmacenCoches()
    @State private var cocheSeleccionado: CocheModel?

    var body: some View {
        VStack {
            /// Selector do coche
            HStack {
                if let coche = cocheSeleccionado {
                    Image(systemName: "car.fill")
                        .foregroundColor(.blue)
                    VStack(alignment: .leading) {
                        Text(coche.marca)
                            .font(.headline)
                        Text(coche.modelo)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                } else {
                    Text("Sen coche seleccionado")
                        .foregroundColor(.gray)
                }
                    
                Spacer()

                // Picker estilo menú a la derecha
                Picker("Selecciona un coche", selection: $cocheSeleccionado) {
                    ForEach(almacenCoches.coches) { coche in
                        Text("\(coche.marca) \(coche.modelo)").tag(coche as CocheModel?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(alignment: .leading)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
            .padding()

            
            /// Lista de mantementos
                         if let coche = cocheSeleccionado {
                             NavigationView {
                             List {
                                 
                                 Section {
                                     NavigationLink {
                                         EngadirMantementoView(coche: coche)
                                     }
                                     label: {
                                         
                                         HStack {
                                             Image(systemName: "widget.large.badge.plus")
                                                 .foregroundColor(.blue)
                                             Text("Engadir un novo mantemento")
                                             Spacer()
                                         }
                                     }
                                 }
                                 
                                 ForEach(coche.mantementos) { mantemento in
                                     NavigationLink(destination: DetalleMantementoView(mantemento: mantemento, coche: cocheSeleccionado!)) {
                                         HStack {
                                             Image(systemName: mantemento.icono)
                                                 .foregroundColor(.blue)
                                             VStack(alignment: .leading) {
                                                 Text(mantemento.titulo)
                                                     .font(.headline)
                                                 Text(mantemento.fechaRegistro.formatted(date: .abbreviated, time: .omitted))
                                                     .font(.subheadline)
                                                     .foregroundColor(.gray)
                                             }
                                         }
                                     }
                                     .buttonStyle(PlainButtonStyle())
                                 }
                             }
                             }
                         } else {
                             Text("Selecciona un coche para ver os seus mantementos")
                                 .foregroundColor(.gray)
                                 .padding()
                             Spacer()
                         }
                     }
            
                     .navigationTitle("Mantementos")
            
        
        .onAppear {
            if cocheSeleccionado == nil {
                cocheSeleccionado = almacenCoches.coches.first
            }
        }
    }
}


#Preview {
    MantementosView()
}
