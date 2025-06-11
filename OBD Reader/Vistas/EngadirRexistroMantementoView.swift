//
//  EngadirRexistroMantementoView.swift
//  OBD Reader
//
//  Created by administrador on 10/6/25.
//

import SwiftUI

struct EngadirRexistroMantementoView: View {
    @Environment(\.dismiss) var cerrarView
    @ObservedObject var mantemento:MantementoModel
    @State var novoRexistro : RexistroMantementoModel = RexistroMantementoModel(fechaMantemento: Date(), anotaciones: "")
    
    var body: some View {
     
        List{
            VStack {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                        Text("Fecha do rexistro")
                }
                DatePicker("", selection: $novoRexistro.fechaMantemento)
                    .labelsHidden()
                    .frame(maxWidth:.infinity, alignment: .center).padding(.top, 5)
            }
            .padding(.vertical)
            .listRowSeparator(.hidden)
            
            VStack{

                HStack {
                    Image(systemName: "pencil.and.scribble")
                        .foregroundColor(.blue)
                    Text("Anotacións do cambio")
                    
                }
              
                TextEditor(text: $novoRexistro.anotaciones)
                    .frame(minHeight: 100)
                    .padding(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5))
                    )            }
            
            VStack{
                Button(action: {
                    mantemento.engadirRexistro(novoRexistro)
                    cerrarView()
                }) {
                    Label("Gardar cambios", systemImage: "square.and.arrow.down")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .frame(maxWidth:.infinity, alignment: .center)
        }
       
    }
}

#Preview {
    @Previewable @StateObject var m : MantementoModel = MantementoModel(fechaRegistro: Date(), proximaNotificacion: Date(), titulo: "Cambio de frenos", descripcion: "Cambio das pastillas de freno", icono: "brakesignal")
    EngadirRexistroMantementoView(mantemento: m)
}
