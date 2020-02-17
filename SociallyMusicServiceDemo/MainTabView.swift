//
//  MainTabView.swift
//  SociallyMusicServiceDemo
//
//  Created by Zach McGuckin on 2/16/20.
//  Copyright © 2020 Zach McGuckin. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CurrentlyPlayingView()
                .tabItem {
                    Image(systemName: "play.fill")
                    Text("Currently Playing")
            }.tag(0)
            RecentlyPlayedView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Recent")
            }.tag(1)
            TopTrackView()
                .tabItem {
                    Image(systemName: "music.note")
                    Text("Top Tracks")
            }.tag(2)
            TopArtistView()
                .tabItem {
                    Image(systemName: "music.mic")
                    Text("Top Artists")
            }.tag(3)
            PlaylistView()
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Playlists")
            }.tag(4)
        }
    }
} 
