////
////  ProbaBluetooth.swift
////  OBD Reader
////
////  Created by administrador on 11/6/25.
////
//
//import SwiftUI
//import SwiftOBD2
//import Combine
//
//class VistaModel: ObservableObject {
//    @Published var measurements: [OBDCommand: MeasurementResult] = [:]
//    @Published var connectionState: ConnectionState = .disconnected
//
//    var cancellables = Set<AnyCancellable>()
//    var requestingPIDs: [OBDCommand] = [.mode1(.rpm)] {
//        didSet {
//            addPID(command: requestingPIDs[-1])
//        }
//    }
//    
//    init() {
//        obdService.$connectionState
//            .assign(to: &$connectionState)
//    }
//
//    let obdService = OBDService(connectionType: .bluetooth)
//
//    func startContinousUpdates() {
//        obdService.startContinuousUpdates([.mode1(.rpm)]) // You can add more PIDs
//            .sink { completion in
//                print(completion)
//            } receiveValue: { measurements in
//                self.measurements = measurements
//            }
//            .store(in: &cancellables)
//    }
//
//    func addPID(command: OBDCommand) {
//        obdService.addPID(command)
//    }
//
//    func stopContinuousUpdates() {
//        cancellables.removeAll()
//    }
//
//    func startConnection() async throws  {
//        let obd2info = try await obdService.startConnection(preferedProtocol: .protocol6)
//        print(obd2info)
//    }
//
//    func stopConnection() {
//        obdService.stopConnection()
//    }
//
//    func switchConnectionType() {
////        obdService.switchConnectionType(.wifi)
//    }
//
//    func getStatus() async {
//        let status = try? await obdService.getStatus()
//        print(status ?? "nil")
//    }
//
//    func getTroubleCodes() async {
//        let troubleCodes = try? await obdService.scanForTroubleCodes()
//        print(troubleCodes ?? "nil")
//    }
//}
//
//struct VistaProbaView: View {
//    @ObservedObject var viewModel = VistaModel()
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Connection State: \(viewModel.connectionState)")
//            ForEach(viewModel.requestingPIDs, id: \.self) { pid in
//                Text("\(pid.properties.description): \(viewModel.measurements[pid]?.value ?? 0) \(viewModel.measurements[pid]?.unit.symbol ?? "")")
//            }
//            Button("Connect") {
//                Task {
//                    do {
//                        try await viewModel.startConnection()
//                        viewModel.startContinousUpdates()
//                    } catch {
//                        print(error)
//                    }
//                }
//            }
//            .buttonStyle(.bordered)
//
//            Button("Stop") {
//                viewModel.stopContinuousUpdates()
//            }
//            .buttonStyle(.bordered)
//
//            Button("Add PID") {
//                viewModel.requestingPIDs.append(.mode1(.speed))
//            }
//        }
//        .padding()
//    }
//}
