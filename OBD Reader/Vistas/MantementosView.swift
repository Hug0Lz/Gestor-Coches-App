//
//  MantementosView.swift
//  OBD Reader
//
//  Created by administrador on 4/6/25.
//

import SwiftUI

struct MantementosView: View {
    @EnvironmentObject var almacenCoches: AlmacenCoches
    @State private var cocheSeleccionadoId: UUID?

    // Computed property para obtener el coche seleccionado
    private var cocheSeleccionado: CocheModel? {
        guard let id = cocheSeleccionadoId else { return nil }
        return almacenCoches.coches.first(where: { $0.id == id })
    }

    var body: some View {
        NavigationView {
            VStack {
                // Selector de coche
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

                    Picker("Selecciona un coche", selection: $cocheSeleccionadoId) {
                        ForEach(almacenCoches.coches) { coche in
                            Text("\(coche.marca) \(coche.modelo)")
                                .tag(coche.id as UUID?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding([.horizontal, .top])

                // Lista de mantenimientos
                if let coche = cocheSeleccionado {
                    List {
                        // Sección para añadir un mantenimiento
                        Section {
                            NavigationLink {
                                EngadirMantementoView(coche: coche)
                            } label: {
                                HStack {
                                    Image(systemName: "widget.large.badge.plus")
                                        .foregroundColor(.blue)
                                    Text("Engadir un novo mantemento")
                                    Spacer()
                                }
                            }
                        }

                        // Sección de mantenimientos existentes
                        Section {
                            ForEach(Array(coche.mantementos.enumerated()), id: \.element.id) { index, mantemento in
                                NavigationLink {
                                    DetalleMantementoView(
                                        mantemento: $almacenCoches
                                            .coches
                                            .first(where: { $0.id == coche.id })!
                                            .mantementos[index]
                                    )
                                } label: {
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
                            }
                            .onDelete(perform: deleteMantenimientos)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                } else {
                    Spacer()
                    Text("Selecciona un coche para ver os seus mantementos")
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .navigationTitle("Mantementos")
            .toolbar {
                // Botón Editar para habilitar onDelete en los mantenimientos
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .onAppear {
                if cocheSeleccionadoId == nil {
                    cocheSeleccionadoId = almacenCoches.coches.first?.id
                }else{
                    let copia = almacenCoches.coches
                          almacenCoches.coches = copia
                }
            }
        }
    }

    // Función para borrar mantenimientos del coche seleccionado
    private func deleteMantenimientos(at offsets: IndexSet) {
        guard let id = cocheSeleccionadoId,
              let carIndex = almacenCoches.coches.firstIndex(where: { $0.id == id })
        else { return }

        withAnimation {
            almacenCoches.coches[carIndex].mantementos.remove(atOffsets: offsets)
        }
    }
}

#Preview {
    let almacen = AlmacenCoches()
    MantementosView()
        .environmentObject(almacen)
}
