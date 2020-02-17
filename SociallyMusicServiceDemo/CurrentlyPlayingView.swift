//
//  CurrentlyPlayingView.swift
//  SociallyMusicServiceDemo
//
//  Created by Zach McGuckin on 2/16/20.
//  Copyright © 2020 Zach McGuckin. All rights reserved.
//

import SwiftUI
import SociallyMusicService

struct CurrentlyPlayingView: View {
    var body: some View {
        Button(action: {
            self.getCurrentTrack()
        }) {
            Text("Get Current Track")
                .background(Color.green)
                .foregroundColor(.white)
                .font(.title)
                .padding()
        }
    }
    
    func getCurrentTrack() {
        let service = SpotifyService(token: Constants.spotifyToken)
        service.fetchCurrentTrack { (result) in
            switch(result) {
            case .success(let track):
                print(track)
            case .failure(let error):
                print(error)
            }
        }
    }
}
