import Foundation
import Combine

class TeslaAPI: ObservableObject {
    private let session = URLSession(configuration: .default)
    private var cancellables = Set<AnyCancellable>()
    @Published var vehicleState: VehicleState?
    
    // Replace with your vehicle ID
    private var vehicleID: String? {
        get { UserDefaults.standard.string(forKey: "TeslaVehicleID") }
        set { UserDefaults.standard.setValue(newValue, forKey: "TeslaVehicleID") }
    }
    
    // OAuth token storage
    private var accessToken: String? {
        get { UserDefaults.standard.string(forKey: "TeslaAccessToken") }
        set { UserDefaults.standard.setValue(newValue, forKey: "TeslaAccessToken") }
    }
    
    func startPolling() {
        Timer.publish(every: 30, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchVehicleData()
            }
            .store(in: &cancellables)
    }
    
    private func fetchVehicleData() {
        guard let vehicleID = vehicleID, let token = accessToken else { return }
        var request = URLRequest(url: URL(string: "https://owner-api.teslamotors.com/api/1/vehicles/\(vehicleID)/vehicle_data")!)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: VehicleDataResponse.self, decoder: JSONDecoder())
            .replaceError(with: VehicleDataResponse(response: nil))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.vehicleState = data.response?.vehicle_state
            }
            .store(in: &cancellables)
    }
}

struct VehicleDataResponse: Codable {
    let response: VehicleData?
}

struct VehicleData: Codable {
    let vehicle_state: VehicleState
}

struct VehicleState: Codable {
    let car_version: String?
    let locked: Bool?
}
