//
//  OBDView.swift
//  OBD Reader
//
//  Created by administrador on 12/6/25.
//

import SwiftUI

struct OBDView: View {
    @State private var demoModeOn = false
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
                
                HStack() {
                    
                    switch demoModeOn {
                    case false:
                        Image(systemName: "wand.and.sparkles")
                            .foregroundColor(.blue)
                        Text("Activar modo Demo")
                        Spacer()
                        Button("Encender") {
                            Task {
                                viewModel.iniciarModoDemo()
                                demoModeOn = true
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        
                        
                        
                        
                    case true:
                        Image(systemName: "wand.and.sparkles")
                            .foregroundColor(.red)
                        Text("Demo activado")
                        Spacer()
                        Button("Apagar") {
                            viewModel.pararModoDemo()
                            demoModeOn = false
                        }
                        .buttonStyle(.bordered)
                        
                        
                    }
                    
                    
                    
                }
                
                
                if demoModeOn {
                    HStack{
                        Image(systemName: "exclamationmark.triangle.fill")
                        Text("Modo Demo Activado")
                        
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(Color.red.opacity(0.25))
                    .cornerRadius(8)
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
                            .tint(.red)
                            .animation(.smooth(duration: 0.5), value: viewModel.coolantTemp)

                        }
                        .frame(maxWidth: .infinity, alignment: .center)

                        
                        VStack{
                            Text("Admisión")
                            Gauge(value: viewModel.intakeAirTemp ?? 0, in: 0...120) {
                                Text("Cº")
                            } currentValueLabel: {
                                Text("\(Int(viewModel.intakeAirTemp ?? 0))")
                            }
                            .gaugeStyle(.accessoryCircular)
                            .tint(.red)
                            .animation(.smooth(duration: 0.5), value: viewModel.intakeAirTemp)

                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        VStack{
                            Text("Aceite")
                            Gauge(value: viewModel.oilTemp ?? 0, in: 0...120) {
                                Text("Cº")
                            } currentValueLabel: {
                                Text("\(Int(viewModel.oilTemp ?? 0))")
                            }
                            .gaugeStyle(.accessoryCircular)
                            .tint(.red)
                            .animation(.smooth(duration: 0.5), value: viewModel.oilTemp)

                        }
                        .frame(maxWidth: .infinity, alignment: .center)

                    }
                }
            
            Section(header: Text("Presiones").font(.headline)) {
                HStack{
                    VStack{
                        Text("MAP")
                        Gauge(value: viewModel.coolantTemp ?? 0, in: 0...400) {
                            Text("kPa")
                        } currentValueLabel: {
                            Text("\(Int(viewModel.coolantTemp ?? 0))")
                        }
                        .gaugeStyle(.accessoryCircular)
                        .tint(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    
                    VStack{
                        Text("Combustible")
                        Gauge(value: viewModel.intakeAirTemp ?? 0, in: 0...15) {
                            Text("psi")
                        } currentValueLabel: {
                            Text("\(Int(viewModel.intakeAirTemp ?? 0))")
                        }
                        .gaugeStyle(.accessoryCircular)
                        .tint(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack{
                        Text("Turbo")
                        Gauge(value: viewModel.intakeAirTemp ?? 0, in: 0...30) {
                            Text("psi")
                        } currentValueLabel: {
                            Text("\(Int(viewModel.intakeAirTemp ?? 0))")
                        }
                        .gaugeStyle(.accessoryCircular)
                        .tint(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                }
            }
            
            Section(header: Text("Motor").font(.headline)) {
                HStack{
                    VStack{
                        Text("RPM")
                        Gauge(value: viewModel.coolantTemp ?? 0, in: 0...120) {
                            Text("rpm")
                        } currentValueLabel: {
                            Text("\(Int(viewModel.coolantTemp ?? 0))")
                        }
                        .gaugeStyle(.accessoryCircular)
                        .tint(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    
                    VStack{
                        Text("Velocidad")
                        Gauge(value: viewModel.speed ?? 0, in: 0...200) {
                            Text("km/h")
                        } currentValueLabel: {
                            Text("\(Int(viewModel.speed ?? 0))")
                        }
                        .gaugeStyle(.accessoryCircular)
                        .tint(.gray)
                        .animation(.smooth(duration: 0.5), value: viewModel.speed)

                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack{
                        Text("Carga motor")
                        Gauge(value: viewModel.motorStress ?? 0, in: 0...100) {
                            Text("psi")
                        } currentValueLabel: {
                            Text("\(Int(viewModel.motorStress ?? 0))")
                        }
                        .gaugeStyle(.accessoryCircular)
                        .tint(.gray)
                        .animation(.smooth(duration: 0.5), value: viewModel.motorStress)

                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                }
            }
            
            
            
            Section(header: Text("Otros").font(.headline)) {
                HStack{
                    VStack{
                        Text("Voltaje")
                        Gauge(value: viewModel.batteryVoltage ?? 0, in: 0...16) {
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
