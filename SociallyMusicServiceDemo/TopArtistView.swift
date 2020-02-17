//
//  TopArtistView.swift
//  SociallyMusicServiceDemo
//
//  Created by Zach McGuckin on 2/16/20.
//  Copyright © 2020 Zach McGuckin. All rights reserved.
//

import SwiftUI
import SociallyMusicService
import ImageWithActivityIndicator

struct TopArtistView: View {
    
    @State var artists = [SociallyArtist]()

    var body: some View {
        List {
            ForEach(artists, id: \.name) { artist in
                TopArtistCellView(artist)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        let service = SpotifyService(token: Constants.spotifyToken)
        service.fetchTopArtists { (result) in
            switch(result) {
            case .success(let artists):
                DispatchQueue.main.async {
                    self.artists += artists
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct TopArtistCellView: View {
    
    let artist: SociallyArtist
    let loader: ViewLoader
    
    init(_ artist: SociallyArtist) {
        self.artist = artist
        self.loader = ViewLoader(url: artist.imageURL)
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ViewWithActivityIndicator(placeHolder: "", showActivityIndicator: true, viewLoader: loader) {
                Image(uiImage: UIImage(data:self.loader.getData()) ?? UIImage()).resizable()
            }.frame(width: 50, height: 50)
            VStack {
                Text(artist.name).font(.headline)
            }
        }
    }
}
