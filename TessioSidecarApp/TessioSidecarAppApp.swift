import SwiftUI

@main
struct TessioSidecarAppApp: App {
    @StateObject private var teslaAPI = TeslaAPI()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(teslaAPI)
                .onAppear {
                    teslaAPI.startPolling()
                }
        }
    }
}
