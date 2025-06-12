//
//  DetalleRexistroMantementoView.swift
//  OBD Reader
//
//  Created by administrador on 10/6/25.
//

import SwiftUI

struct DetalleRexistroMantementoView: View {
    @ObservedObject var detalle: RexistroMantementoModel
    var body: some View {
     
                Form {
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        DatePicker("Fecha mantemento", selection: $detalle.fechaMantemento, displayedComponents: .date)
                    }
                    
                    HStack {
                        Image(systemName: "road.lanes")
                            .foregroundColor(.blue)
                        Text("Kilometraxe")
                        Spacer()
                        TextField("Kilometraxe", value: $detalle.kilometraxe, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    
                    Section(header: Text("Anotacións").font(.headline)) {
                    
                        
                        TextEditor(text: $detalle.anotaciones)
                            .frame(minHeight: 100)
                            .padding(4)
                          
                    }
                .navigationTitle("Detalle do Mantemento")
                .navigationBarTitleDisplayMode(.inline)
            }
        
    }
}

#Preview {
    @ObservedObject var det =  RexistroMantementoModel( fechaMantemento: Date(), anotaciones: "O tornillo estaba algo oxidado. Boteille grasa de litio para a próxima!", kilometraxe: 200)
    DetalleRexistroMantementoView(detalle: det)
}
