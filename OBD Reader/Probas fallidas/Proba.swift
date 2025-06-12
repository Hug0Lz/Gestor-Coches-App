////
////  Proba.swift
////  OBD Reader
////
////  Created by administrador on 9/6/25.
////
//
//import SwiftUI
//import SwiftOBD2
//import Combine
//  
//class RPMViewModel: ObservableObject {
//    @Published var rpm: Double = 0
//    @Published var connectionState: ConnectionState = .disconnected
//    @Published var isConnecting: Bool = false
//      
//    private var cancellables = Set<AnyCancellable>()
//    private let obdService = OBDService(connectionType: .bluetooth)
//      
//    init() {
//        // Observe connection state changes
//        obdService.$connectionState
//            .assign(to: &$connectionState)
//    }
//      
//    func startConnection() async {
//        isConnecting = true
//        do {
//            _ = try await obdService.startConnection()
//            startRPMUpdates()
//        } catch {
//            print("Connection failed: \(error)")
//        }
//        isConnecting = false
//    }
//      
//    func stopConnection() {
//        stopRPMUpdates()
//        obdService.stopConnection()
//    }
//      
//    private func startRPMUpdates() {
//        obdService.startContinuousUpdates([.mode1(.rpm)], interval: 0.2)
//            .sink { completion in
//                if case .failure(let error) = completion {
//                    print("RPM updates failed: \(error)")
//                }
//            } receiveValue: { [weak self] measurements in
//                if let rpmResult = measurements[.mode1(.rpm)] {
//                    self?.rpm = rpmResult.value
//                }
//            }
//            .store(in: &cancellables)
//    }
//      
//    private func stopRPMUpdates() {
//        cancellables.removeAll()
//    }
//}
//  
//struct RPMView: View {
//    @StateObject private var viewModel = RPMViewModel()
//      
//    var body: some View {
//        VStack(spacing: 30) {
//            // RPM Display
//            VStack(spacing: 10) {
//                Text("ENGINE RPM")
//                    .font(.headline)
//                    .foregroundColor(.secondary)
//                  
//                Text("\(Int(viewModel.rpm))")
//                    .font(.system(size: 72, weight: .bold, design: .rounded))
//                    .foregroundColor(rpmColor)
//                    .animation(.easeInOut(duration: 0.3), value: viewModel.rpm)
//                  
//                Text("RPM")
//                    .font(.title2)
//                    .foregroundColor(.secondary)
//            }
//              
//            // RPM Gauge
//            RPMGauge(rpm: viewModel.rpm)
//                .frame(width: 200, height: 200)
//              
//            // Connection Status
//            HStack {
//                Circle()
//                    .fill(connectionStatusColor)
//                    .frame(width: 12, height: 12)
//                  
//                Text(connectionStatusText)
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//            }
//              
//            // Connect/Disconnect Button
//            Button(action: {
//                if viewModel.connectionState == .connectedToVehicle {
//                    viewModel.stopConnection()
//                } else {
//                    Task {
//                        await viewModel.startConnection()
//                    }
//                }
//            }) {
//                Text(buttonText)
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(buttonColor)
//                    .cornerRadius(12)
//            }
//            .disabled(viewModel.isConnecting)
//        }
//        .padding()
//        .navigationTitle("RPM Monitor")
//    }
//      
//    private var rpmColor: Color {
//        switch viewModel.rpm {
//        case 0..<1000: return .green
//        case 1000..<3000: return .blue
//        case 3000..<5000: return .orange
//        default: return .red
//        }
//    }
//      
//    private var connectionStatusColor: Color {
//        switch viewModel.connectionState {
//        case .disconnected: return .red
//        case .connectedToAdapter: return .yellow
//        case .connectedToVehicle: return .green
//        }
//    }
//      
//    private var connectionStatusText: String {
//        switch viewModel.connectionState {
//        case .disconnected: return "Disconnected"
//        case .connectedToAdapter: return "Connected to Adapter"
//        case .connectedToVehicle: return "Connected to Vehicle"
//        }
//    }
//      
//    private var buttonText: String {
//        if viewModel.isConnecting {
//            return "Connecting..."
//        } else if viewModel.connectionState == .connectedToVehicle {
//            return "Disconnect"
//        } else {
//            return "Connect"
//        }
//    }
//      
//    private var buttonColor: Color {
//        if viewModel.connectionState == .connectedToVehicle {
//            return .red
//        } else {
//            return .blue
//        }
//    }
//}
//  
//struct RPMGauge: View {
//    let rpm: Double
//    private let maxRPM: Double = 8000
//      
//    var body: some View {
//        ZStack {
//            // Background circle
//            Circle()
//                .stroke(Color.gray.opacity(0.3), lineWidth: 20)
//              
//            // RPM arc
//            Circle()
//                .trim(from: 0, to: min(rpm / maxRPM, 1.0))
//                .stroke(
//                    AngularGradient(
//                        gradient: Gradient(colors: [.green, .yellow, .orange, .red]),
//                        center: .center
//                    ),
//                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
//                )
//                .rotationEffect(.degrees(-90))
//                .animation(.easeInOut(duration: 0.5), value: rpm)
//              
//            // Center text
//            VStack {
//                Text("\(Int(rpm))")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                Text("RPM")
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//            }
//        }
//    }
//}
//  
//struct ProbaView: View {
//    var body: some View {
//        NavigationView {
//            RPMView()
//        }
//    }
//}
