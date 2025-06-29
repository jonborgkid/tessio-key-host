import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MusicView()
                .tabItem {
                    Image(systemName: "music.note")
                    Text("Music")
                }
            PodcastsView()
                .tabItem {
                    Image(systemName: "dot.radiowaves.left.and.right")
                    Text("Podcasts")
                }
            AudiobooksView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Audiobooks")
                }
            VideosView()
                .tabItem {
                    Image(systemName: "tv")
                    Text("Videos")
                }
            NowPlayingView()
                .tabItem {
                    Image(systemName: "play.circle")
                    Text("Now Playing")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
