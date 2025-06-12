//
//  CochesView.swift
//  OBD Reader
//
//  Created by administrador on 10/6/25.
//

import SwiftUI

struct CochesView: View {
    @EnvironmentObject var cochesViewModel: AlmacenCoches

    var body: some View {
        NavigationView {
            List {
                // Botón para engadir novo coche
                Section {
                    NavigationLink {
                        EngadirCocheView(coches: $cochesViewModel.coches)
                    } label: {
                        HStack {
                            Image(systemName: "car.side")
                                .foregroundColor(.blue)
                            Text("Engadir un novo coche")
                            Spacer()
                        }
                    }
                }

                // Sección coa lista de coches
                Section {
                    ForEach(cochesViewModel.coches) { coche in
                        NavigationLink {
                            EditarCocheView(coche: coche)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(coche.marca)
                                    .font(.headline)
                                Text("\(coche.modelo) - \(coche.matricula)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete(perform: deleteCoche)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Lista de Coches")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//            }
        }
    }

    // Método para borrar coches polos IndexSet
    private func deleteCoche(at offsets: IndexSet) {
        withAnimation {
            cochesViewModel.coches.remove(atOffsets: offsets)
        }
    }
}

#Preview {
    let almacen = AlmacenCoches()
    CochesView()
        .environmentObject(almacen)
}
