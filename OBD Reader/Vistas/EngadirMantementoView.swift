//
//  EngadirMantementoView.swift
//  OBD Reader
//
//  Created by administrador on 10/6/25.
//

import SwiftUI
import SFSymbolsPicker

struct EngadirMantementoView: View {
    @Environment(\.dismiss) var cerrarView
    @ObservedObject var coche: CocheModel
    @StateObject var novoMantemento: MantementoModel = MantementoModel()
    @State private var toggleSelectorBoton = false

    var body: some View {
        List{
            
            Section{
                HStack {
                    Button {
                        toggleSelectorBoton.toggle()
                    } label: {
                        HStack{
                            Image(systemName: novoMantemento.icono)
                            TextField("Título do mantemento...", text: $novoMantemento.titulo)
                                .font(.title2)
                        }
                    }
                    .sheet(isPresented: $toggleSelectorBoton) {
                        SymbolsPicker(selection: $novoMantemento.icono, title: "Elige un icono para el mantenimiento", autoDismiss: true)
                    }
                }
            }
          
            Section {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                    Text("Fecha de rexistro:")
                    Spacer()
                    Text(novoMantemento.fechaRegistro.formatted(date: .abbreviated, time: .omitted))
                }
            }
            .padding(.vertical)
            .listRowSeparator(.hidden)
            
            Section{
                
                HStack {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.blue)
                    Text("Descripción do mantemento")
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)
                
                
                TextEditor(text: $novoMantemento.descripcion)
                    .frame(minHeight: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5))
                    )
            }
            .padding(.bottom)
            
            Section{
                Button(action: {
                    coche.engadirMantemento(novoMantemento)
                    cerrarView()
                }) {
                    HStack{
                        Image(systemName: "square.and.arrow.down")
                        Text("Gardar novo mantemento")
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
    struct PreviewContainer: View {
        @StateObject var coche = CocheModel(marca: "Citroen", modelo: "Xantia", matricula: "1234BBB")

        var body: some View {
            EngadirMantementoView(coche: coche)
        }
    }

    return PreviewContainer()
}
