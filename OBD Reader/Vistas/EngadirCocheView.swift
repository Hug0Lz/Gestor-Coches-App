//
//  EngadirCocheView.swift
//  OBD Reader
//
//  Created by administrador on 12/6/25.
//

import SwiftUI

struct EngadirCocheView: View {
    @Environment(\.dismiss) var cerrarView
    @Binding var coches: [CocheModel]
    @StateObject var novoCoche : CocheModel = CocheModel()
    var body: some View {
     
        List{
            Section(header: Text("Marca")) {
                
                HStack {
                    Image(systemName: "car.2.fill")
                        .foregroundColor(.blue)
                    TextField("Introduce la marca", text: $novoCoche.marca)
                }
            }
            
            Section(header: Text("Modelo")) {
                
                HStack {
                    Image(systemName: "car.fill")
                        .foregroundColor(.blue)
                    TextField("Introduce el modelo", text: $novoCoche.modelo)
                }
            }
            
            Section(header: Text("Matrícula")) {
                
                HStack {
                    Image(systemName: "licenseplate")
                        .foregroundColor(.blue)
                    TextField("Introduce la matrícula", text: $novoCoche.matricula)
                }
            }
            
            Section{
                Button(action: {
                    coches.append(novoCoche)
                    cerrarView()
                }) {
                    HStack{
                        Image(systemName: "square.and.arrow.down")
                        Text("Gardar novo coche")
                    }
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color.blue)
                    .cornerRadius(10)
                   
                }
            }
            .frame(maxWidth:.infinity, alignment: .center)
            .listRowBackground(Color(.systemGray6))
           
        }
        
    }
}

#Preview {
    @Previewable @StateObject var cochesViewModel = AlmacenCoches()

    EngadirCocheView(coches: $cochesViewModel.coches)
}
