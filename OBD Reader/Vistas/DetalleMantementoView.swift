//
//  DetalleMantementoView.swift
//  OBD Reader
//
//  Created by administrador on 9/6/25.
//


import SwiftUI

struct DetalleMantementoView: View {
    @Binding var mantemento: MantementoModel
//    @ObservedObject var coche: CocheModel

    var body: some View {
        Form {
            Section(header: Text("Información").font(.headline)) {
                HStack{
                    Image(systemName: mantemento.icono)
                        .foregroundColor(.blue)
                    Text(mantemento.titulo)
                        .font(.title)
                }

                Text(mantemento.descripcion)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                HStack( spacing: 12) {
                    // Fecha de registro
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Data de rexistro")
                            .font(.caption)
                            .foregroundColor(.gray)

                        HStack(spacing: 6) {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                            Text(mantemento.fechaRegistro.formatted(date: .abbreviated, time: .omitted))
                        }
                    }
                    .frame(maxWidth: .infinity)

                    // Próxima notificación
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Próxima notificación")
                            .font(.caption)
                            .foregroundColor(.gray)

                        HStack(spacing: 6) {
                            Image(systemName: "bell")
                                .foregroundColor(.orange)
                            Text(mantemento.proximaNotificacion.formatted(date: .abbreviated, time: .omitted))
                        }
                    }
                    .frame(maxWidth: .infinity)

                }
                .padding(.vertical, 5)
            }
            
            Section {
                NavigationLink {
                    EngadirRexistroMantementoView(mantemento: mantemento)
                }
                label: {
                    
                    HStack {
                        Image(systemName: "widget.large.badge.plus")
                            .foregroundColor(.blue)
                        Text("Engadir un novo Rexistro")
                        Spacer()
                    }
                }
            }

            Section(header: Text("Rexistro dos mantementos")) {
                List {
                    ForEach(mantemento.listaMantementos) { rexistro in
                        NavigationLink {
                            DetalleRexistroMantementoView(detalle: rexistro)
                        } label: {
                            HStack {
                                Image(systemName: "wrench.and.screwdriver")
                                    .foregroundColor(.blue)
                                Text(rexistro.fechaMantemento.formatted(date: .abbreviated, time: .omitted))
                            }
                        }

                    
                    }
                    
                }
            }
        }
        .navigationTitle("Detalle do Mantemento")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    @Previewable @State var m:MantementoModel = MantementoModel(fechaRegistro: Date(), proximaNotificacion: Date(), titulo: "Cambio discos freo", descripcion: "Cambio dos discos dianteiros e as súas pastillas", icono: "brakesignal", listaMantementos: [RexistroMantementoModel(fechaMantemento: Date(), anotaciones: "Botóuselle grasa de litio para que sexa máis sinxelo quitar o disco a próxima vez", kilometraxe: 204203)])
    @ObservedObject var coche:CocheModel = CocheModel(marca: "Citroen", modelo: "Xantia", matricula: "1234BBB")
    DetalleMantementoView(mantemento: $m)
}
