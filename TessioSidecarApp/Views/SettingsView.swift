import SwiftUI

struct SettingsView: View {
    @AppStorage("TeslaVehicleID") private var vehicleID: String = ""
    @AppStorage("TeslaAccessToken") private var accessToken: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tesla Credentials")) {
                    TextField("Vehicle ID", text: $vehicleID)
                    SecureField("Access Token", text: $accessToken)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
