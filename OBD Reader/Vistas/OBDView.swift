//
//  OBDView.swift
//  OBD Reader
//
//  Created by administrador on 12/6/25.
//

import SwiftUI

struct OBDView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        List{
            Section(header: Text("Estado de conexión").font(.headline)){
                HStack() {
                    
                    switch viewModel.connectionState {
                    case .disconnected:
                        Image(systemName: "personalhotspot.slash")
                            .foregroundColor(.blue)
                        Text("Desconectado")
                        Spacer()
                        Button("Conectar") {
                            Task {
                                await viewModel.startConnection()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        
                    case .connectedToAdapter:
                        ProgressView()
                        Text("Conectando...")
                        
                    case .connectedToVehicle:
                        Image(systemName: "personalhotspot")
                            .foregroundColor(.blue)
                        Text("Conectado a la ECU")
                        Spacer()
                        Button("Desconectar") {
                            viewModel.stopConnection()
                        }
                        .buttonStyle(.bordered)
                        
                        
                    }
                }
               
            }
            
            
        
    
                Section(header: Text("Temperaturas").font(.headline)) {
                    HStack{
                        VStack{
                            Text("Refrigerante")
                            Gauge(value: viewModel.coolantTemp ?? 0, in: 0...120) {
                                Text("Cº")
                            } currentValueLabel: {
                                Text("\(Int(viewModel.coolantTemp ?? 0))")
                            }
                            .gaugeStyle(.accessoryCircular)
                            .tint(.blue)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)

                        
                        VStack{
                            Text("Intake aire")
                            Gauge(value: viewModel.intakeAirTemp ?? 0, in: 0...120) {
                                Text("Cº")
                            } currentValueLabel: {
                                Text("\(Int(viewModel.intakeAirTemp ?? 0))")
                            }
                            .gaugeStyle(.accessoryCircular)
                            .tint(.blue)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)

                    }
                }
            
            Section(header: Text("Otros").font(.headline)) {
                HStack{
                    VStack{
                        Text("Voltaje")
                        Gauge(value: viewModel.batteryVoltage ?? 0, in: 0...120) {
                            Text("V")
                        } currentValueLabel: {
                            Text("\(Int(viewModel.batteryVoltage ?? 0))")
                        }
                        .gaugeStyle(.accessoryCircular)
                        .tint(.red)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    
                    VStack{
                        Text("RPM")
                        Gauge(value: viewModel.intakeAirTemp ?? 0, in: 0...10000) {
                            Text("rpm")
                        } currentValueLabel: {
                            Text("\(Int(viewModel.intakeAirTemp ?? 0))")
                        }
                        .gaugeStyle(.accessoryCircular)
                        .tint(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                }
            }
      
//            VStack{
//                
//                if let temp = viewModel.coolantTemp {
//                    Text("🌡️ Temperatura refrigerante: \(String(format: "%.1f", temp)) °C")
//                        .font(.title2)
//                } else {
//                    Text("🌡️ Temperatura refrigerante: -- °C")
//                        .font(.title2)
//                        .foregroundColor(.secondary)
//                }
//                
//                if let temp = viewModel.intakeAirTemp {
//                    Text("🌡️ Temperatura entrada aire: \(String(format: "%.1f", temp)) °C")
//                        .font(.title2)
//                } else {
//                    Text("🌡️ Temperatura entrada aire: -- °C")
//                        .font(.title2)
//                        .foregroundColor(.secondary)
//                }
//                if let temp = viewModel.batteryVoltage {
//                    Text("🌡️ Voltaje de la batería: \(String(format: "%.1f", temp))V")
//                        .font(.title2)
//                } else {
//                    Text("🌡️ Voltaje de la batería: --V")
//                        .font(.title2)
//                        .foregroundColor(.secondary)
//                }
//                if let temp = viewModel.engineRPM {
//                    Text("🌡️ Revoluciones por minuto: \(String(format: "%.1f", temp)) rpm")
//                        .font(.title2)
//                } else {
//                    Text("🌡️ Revoluciones por minuto: -- rpm")
//                        .font(.title2)
//                        .foregroundColor(.secondary)
//                }
//                
//                
//                
//                if let rpm = viewModel.engineRPM {
//                    Gauge(value: rpm, in: 0...8000) {
//                        Text("RPM")
//                    } currentValueLabel: {
//                        Text("\(Int(rpm))")
//                    }
//                    .gaugeStyle(.accessoryCircular)
//                    .tint(.red)
//                    .frame(width: 150, height: 150)
//                }
//                
//                if let temp = viewModel.throttlePosition {
//                    Text("🌡️ Porcentaje de acelerador: \(String(format: "%.1f", temp)) %")
//                        .font(.title2)
//                } else {
//                    Text("🌡️ Porcentaje de acelerador: -- %")
//                        .font(.title2)
//                        .foregroundColor(.secondary)
//                }
//                
//                
//            }
//            .padding()
        }
    }
}

#Preview {
    OBDView()
}
