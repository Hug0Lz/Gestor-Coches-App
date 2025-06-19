import SwiftUI
import SwiftOBD2
import Combine

@MainActor
class ViewModel: ObservableObject {
    @Published var connectionState: ConnectionState = .disconnected
    @Published var measurements: [OBDCommand: MeasurementResult] = [:]
    
    @Published var coolantTemp: Double? = nil
    @Published var intakeAirTemp: Double? = nil
    @Published var oilTemp: Double? = nil
    @Published var batteryVoltage: Double? = nil
    @Published var engineRPM: Double? = nil
    @Published var throttlePosition: Double? = nil
    @Published var mapSensor: Double? = nil
    @Published var speed: Double? = nil
    @Published var motorStress: Double? = nil
    @Published var revs: Double? = nil

    


    var cancellables = Set<AnyCancellable>()
    let obdService = OBDService(connectionType: .bluetooth)
    private var demoTimer: Timer?

    init() {
        // Vincula el estado de conexión
        obdService.$connectionState
            .assign(to: &$connectionState)
    }

    


      func iniciarModoDemo() {
          demoTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
              DispatchQueue.main.async {
                  self.coolantTemp = Double.random(in: 60...110)
                  self.intakeAirTemp = Double.random(in: 20...60)
                  self.oilTemp = Double.random(in: 60...100)
                  self.mapSensor = Double.random(in: 10...400)
                  self.speed = Double.random(in: 1...199)
                  self.motorStress = Double.random(in: 0...100)
                  self.revs = Double.random(in: 0...10000)
              }
          }
      }

      func pararModoDemo() {
          demoTimer?.invalidate()
          demoTimer = nil
      }
    
    
    func startConnection() async {
        do {
            print("Intentando conectar con el OBD-II...")

            // Intentar conexión con el protocolo ISO 9141-2 (compatible con Citroën Xantia 2000)
            let obd2info = try await obdService.startConnection()
            
            
            print("Conexión establecida con: \(obd2info)")

            // 🔧 Obtener datos esenciales del vehículo
        

            sendRawCoolantTempCommand()
                
                // Esperar 1 segundo
                try await Task.sleep(nanoseconds: 1_000_000_000)

                // Enviar comando temp aire admisión
                sendRawIntakeAirTempCommand()
            
            // Esperar 1 segundo
            try await Task.sleep(nanoseconds: 1_000_000_000)

            // Enviar comando temp aire admisión
            sendBatteryVoltageCommand()
            
            // Esperar 1 segundo
            try await Task.sleep(nanoseconds: 1_000_000_000)

            // Enviar comando temp aire admisión
            sendRPMCommand()
            
            // Esperar 1 segundo
            try await Task.sleep(nanoseconds: 1_000_000_000)

            // Enviar comando temp aire admisión
            sendThrottlePositionCommand()

        } catch {
            print("Error al conectar con OBD-II: \(error.localizedDescription)")
        }
    }


    


    


//    private var continuousUpdatesCancellable: AnyCancellable?
//
//    func startContinuousUpdates() {
//        continuousUpdatesCancellable?.cancel()
//
//        continuousUpdatesCancellable = obdService.startContinuousUpdates([.mode1(.coolantTemp)])
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//                print("ERROR : \(completion)")
//            } receiveValue: { measurements in
//                self.measurements = measurements
//                print("Temperatura Refrigerante: \(self.measurements)")
//            }
//    }


    private var isSendingCommand = false
//    private var cancellables = Set<AnyCancellable>()

    func startContinuousUpdates() {
        Timer.publish(every: 2.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if !self.isSendingCommand {
                    self.sendRawCoolantTempCommand()
                } else {
                    print("Esperando respuesta anterior")
                }
            }
            .store(in: &cancellables)
    }

   
    func sendRawCoolantTempCommand() {
        Task {
            do {
                print("Enviando comando manual: 0105 (Coolant Temp)")
                
                let rawResponse = try await obdService.sendCommandInternal("0105", retries: 3)

                guard let rawLine = rawResponse.first else {
                    print("Respuesta vacía")
                    return
                }

                print("Respuesta raw: \(rawLine)")

                // Extraemos los últimos 2 caracteres como byte (ej: "75")
                let hexByte = String(rawLine.suffix(2))

                if let byteValue = UInt8(hexByte, radix: 16) {
                    let temperature = Double(byteValue) - 40.0
                    print("Temp refrigerante (decodificada manualmente): \(temperature) °C")

                    // Actualizamos la propiedad measurements para que la UI la pueda usar si quieres
                    let result = MeasurementResult(value: temperature, unit: UnitTemperature.celsius)

                    DispatchQueue.main.async {
                        self.measurements = [.mode1(.coolantTemp): result]
                        self.coolantTemp = temperature
                    }
                } else {
                    print("No se pudo convertir el byte: \(hexByte)")
                }

            } catch {
                print("Error al enviar comando manual: \(error)")
            }
        }
    }
    
    
    func sendRawIntakeAirTempCommand() {
        Task {
            do {
                print("Enviando comando manual: 010F (Intake Air Temp)")
                
                let rawResponse = try await obdService.sendCommandInternal("010F", retries: 3)
                
                guard let rawLine = rawResponse.first else {
                    print("Respuesta vacía")
                    return
                }
                
                print("Respuesta raw: \(rawLine)")
                
                // Extraemos el último byte (2 caracteres hex) que contiene la temperatura
                let hexByte = String(rawLine.suffix(2))
                
                if let byteValue = UInt8(hexByte, radix: 16) {
                    let temperature = Double(byteValue) - 40.0
                    print("Temp aire de admisión (manualmente): \(temperature) °C")
                    
//                    let result = MeasurementResult(value: temperature, unit: UnitTemperature.celsius)
                    DispatchQueue.main.async {
                        self.intakeAirTemp = temperature
                    }
                } else {
                    print("No se pudo convertir el byte: \(hexByte)")
                }
                
            } catch {
                print("Error al enviar comando manual: \(error)")
            }
        }
    }

    func sendBatteryVoltageCommand() {
           Task {
               do {
                   print("Enviando comando manual: ATRV (Voltaje batería)")

                   let rawResponse = try await obdService.sendCommandInternal("ATRV", retries: 3)

                   guard let rawLine = rawResponse.first else {
                       print("Respuesta vacía")
                       return
                   }

                   print("Respuesta cruda: \(rawLine)")

                   // Respuesta típica: "12.6V"
                   // Extraemos el valor numérico antes de la "V"
                   let voltageString = rawLine.trimmingCharacters(in: .whitespacesAndNewlines)
                       .replacingOccurrences(of: "V", with: "")

                   if let voltage = Double(voltageString) {
                       print("Voltaje batería: \(voltage) V")
                       DispatchQueue.main.async {
                           self.batteryVoltage = voltage
                       }
                   } else {
                       print("No se pudo convertir el voltaje: \(voltageString)")
                   }
               } catch {
                   print("Error al enviar comando ATRV: \(error)")
               }
           }
       }
    
    func sendRPMCommand() {
        Task {
            do {
                print("Enviando comando manual: 010C (RPM del motor)")

                let rawResponse = try await obdService.sendCommandInternal("010C", retries: 3)

                guard let rawLine = rawResponse.first else {
                    print("Respuesta vacía")
                    return
                }

                print("Respuesta raw: \(rawLine)")

                // Elimina espacios por si vienen
                let cleanHex = rawLine.replacingOccurrences(of: " ", with: "")

                // Buscar el índice donde empieza "410C"
                guard let range = cleanHex.range(of: "410C") else {
                    print("No se encontró 410C en la respuesta")
                    return
                }

                // A y B son los dos bytes siguientes a "410C" (8 caracteres adelante)
                let startIndex = range.upperBound

                let aHex = String(cleanHex[startIndex..<cleanHex.index(startIndex, offsetBy: 2)])
                let bHex = String(cleanHex[cleanHex.index(startIndex, offsetBy: 2)..<cleanHex.index(startIndex, offsetBy: 4)])

                guard let a = UInt8(aHex, radix: 16), let b = UInt8(bHex, radix: 16) else {
                    print("Error al convertir los bytes A o B")
                    return
                }

                let rpm = Double((Int(a) << 8) + Int(b)) / 4.0
                print("RPM motor: \(rpm)")

                DispatchQueue.main.async {
                    self.engineRPM = rpm
                }

            } catch {
                print("Error al enviar comando RPM: \(error)")
            }
        }
    }
    
    func sendThrottlePositionCommand() {
        Task {
            do {
                print("Enviando comando crudo: 0111 (Throttle Position)")

                let rawResponse = try await obdService.sendCommandInternal("0111", retries: 3)

                guard let rawLine = rawResponse.first else {
                    print("Respuesta vacía")
                    return
                }

                print("Respuesta cruda: \(rawLine)")

                // Extraemos los dos últimos caracteres como byte
                let hexByte = String(rawLine.suffix(2))

                if let byteValue = UInt8(hexByte, radix: 16) {
                    let throttle = (Double(byteValue) * 100.0) / 255.0
                    print("Posición del acelerador: \(throttle)%")

                    DispatchQueue.main.async {
                        self.throttlePosition = throttle
                    }
                } else {
                    print("No se pudo convertir el byte: \(hexByte)")
                }

            } catch {
                print("Error al enviar comando crudo: \(error)")
            }
        }
    }



    

















    func stopConnection() {
        obdService.stopConnection()
        print("Conexión detenida")
    }
    
    func enviarComando(_ comando: OBDCommand) {
        obdService.addPID(comando) // Agrega el comando a la lista de PIDs
        print("Enviando comando OBD-II: \(comando)")
    }



}

