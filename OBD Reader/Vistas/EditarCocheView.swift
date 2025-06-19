//
//  EditarCocheView.swift
//  OBD Reader
//
//  Created by administrador on 10/6/25.
//

import SwiftUI

struct EditarCocheView: View {
    @Binding var coche: CocheModel
    var body: some View {
     
        List{
            Section(header: Text("Marca")) {
                
                HStack {
                    Image(systemName: "car.2.fill")
                        .foregroundColor(.blue)
                    TextField("Introduce la marca", text: $coche.marca)
                }
            }
            
            Section(header: Text("Modelo")) {
                
                HStack {
                    Image(systemName: "car.fill")
                        .foregroundColor(.blue)
                    TextField("Introduce el modelo", text: $coche.modelo)
                }
            }
            
            Section(header: Text("Matrícula")) {
                
                HStack {
                    Image(systemName: "licenseplate")
                        .foregroundColor(.blue)
                    TextField("Introduce la matrícula", text: $coche.matricula)
                }
            }
           
           
        }
        
    }
}
//
//#Preview {
//    @Binding var coche = CocheModel(marca: "Citroen", modelo: "Xantia", matricula: "1234BBB")
//
//    EditarCocheView(coche: $coche)
//}
