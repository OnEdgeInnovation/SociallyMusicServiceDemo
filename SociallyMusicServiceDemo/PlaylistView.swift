//
//  PlaylistView.swift
//  SociallyMusicServiceDemo
//
//  Created by Zach McGuckin on 2/16/20.
//  Copyright © 2020 Zach McGuckin. All rights reserved.
//

import SwiftUI
import SociallyMusicService
import ImageWithActivityIndicator

struct PlaylistView: View {
    
    @State var playlists = [SociallyPlaylist]()

    var body: some View {

        List {
            ForEach(playlists, id: \.name) { playlist in
                PlaylistCellView(playlist)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        let service = SpotifyService()
        service.setToken(accessToken: Constants.spotifyToken)
        service.getPlaylists { (result) in
            switch(result) {
            case .success(let playlists):
                DispatchQueue.main.async {
                    self.playlists = playlists
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct PlaylistCellView: View {
    
    let playlist: SociallyPlaylist
    let loader: ViewLoader
    
    init(_ playlist: SociallyPlaylist) {
        self.playlist = playlist
        self.loader = ViewLoader(url: playlist.imageURL?.absoluteString ?? "")
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ViewWithActivityIndicator(placeHolder: "", showActivityIndicator: true, viewLoader: loader) {
                Image(uiImage: UIImage(data:self.loader.getData()) ?? UIImage()).resizable()
            }.frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(playlist.name).font(.headline)
                Text(playlist.authorName).font(.subheadline)
            }
        }
    }
}
