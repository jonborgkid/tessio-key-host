# Tessio Sidecar App

This repository contains a prototype of the Tessio Sidecar App, an iPad application designed to complement Tesla vehicles. The app is built with SwiftUI and integrates with the Tesla Owner API to synchronize vehicle settings and state.

## Features

- **Media Dashboard** with tabs for Music, Podcasts, Audiobooks, Videos, and Now Playing.
- **Tesla API Integration** to pull vehicle data, adapt the UI theme, and detect parked or driving state.
- **OAuth-based logins** for third-party media services (Apple Music, Spotify, Pandora, Audible, Apple Podcasts, ABetterTheater). These are represented by placeholders in the code.
- **Secure token storage** using `UserDefaults` and the Keychain (not fully implemented in this prototype).
- **Settings tab** to configure Tesla API credentials.

## Running the App

The project is provided as a SwiftUI skeleton. Open the `TessioSidecarApp` folder in Xcode to build and run the application on an iPad simulator or device. You will need to supply your own Tesla Owner API credentials and vehicle ID.

The app polls the Tesla Owner API every 30 seconds to keep settings in sync. Credentials entered in the Settings tab are stored using `@AppStorage`.

## Disclaimer

This is a minimal demonstration and does not include complete authentication flows or media playback logic. It is intended as a starting point for further development.
