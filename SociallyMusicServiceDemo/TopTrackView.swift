//
//  TopTrackView.swift
//  SociallyMusicServiceDemo
//
//  Created by Zach McGuckin on 2/16/20.
//  Copyright © 2020 Zach McGuckin. All rights reserved.
//

import SwiftUI
import SociallyMusicService
import ImageWithActivityIndicator

struct TopTrackView: View {
    
    @State var tracks = [SociallyTrack]()

    var body: some View {

        List {
            ForEach(tracks, id: \.name) { track in
                TopTrackCellView(track)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        let service = SpotifyService()
        service.setToken(accessToken: Constants.spotifyToken)
        service.fetchTopSongs { (result) in
            switch(result) {
            case .success(let tracks):
                DispatchQueue.main.async {
                    self.tracks += tracks
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct TopTrackCellView: View {
    
    let track: SociallyTrack
    let loader: ViewLoader
    
    init(_ track: SociallyTrack) {
        self.track = track
        self.loader = ViewLoader(url: track.imageURL)
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ViewWithActivityIndicator(placeHolder: "", showActivityIndicator: true, viewLoader: loader) {
                Image(uiImage: UIImage(data:self.loader.getData()) ?? UIImage()).resizable()
            }.frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(track.name).font(.headline)
                Text(track.artist).font(.subheadline)
            }
        }
    }
}
