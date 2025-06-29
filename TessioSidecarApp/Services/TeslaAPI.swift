import Foundation
import Combine
import SwiftUI

class TeslaAPI: ObservableObject {
    @AppStorage("TeslaAccessToken") private var accessToken: String = ""
    @AppStorage("TeslaVehicleID") private var vehicleID: String = ""

    @Published var vehicleState: VehicleState?
    @Published var guiSettings: GUISettings?

    private var timer: Timer?

    func startPolling() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            Task { await self?.fetchVehicleData() }
        }
        timer?.tolerance = 5
        timer?.fire()
    }

    func stopPolling() {
        timer?.invalidate()
    }

    private func fetchVehicleData() async {
        guard !vehicleID.isEmpty, !accessToken.isEmpty else { return }
        var request = URLRequest(url: URL(string: "https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleID)/vehicle_data")!)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(VehicleDataResponse.self, from: data)
            await MainActor.run {
                self.vehicleState = decoded.response?.vehicle_state
                self.guiSettings = decoded.response?.gui_settings
            }
        } catch {
            // In this prototype we silently ignore errors
        }
    }
}

struct VehicleDataResponse: Codable {
    let response: VehicleData?
}

struct VehicleData: Codable {
    let vehicle_state: VehicleState
    let gui_settings: GUISettings
}

struct VehicleState: Codable {
    let car_version: String?
    let locked: Bool?
}

struct GUISettings: Codable {
    let gui_24_hour_time: Bool?
    let gui_distance_units: String?
}
