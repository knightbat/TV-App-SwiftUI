//
//  EpisodeView.swift
//  TV-App-SwiftUI
//
//  Created by Jayakrishnan M on 22/10/19.
//  Copyright © 2019 ltrix. All rights reserved.
//

import SwiftUI

struct EpisodeView: View {
    
    @ObservedObject var episodeStore: EpisodeStore
    @State var selectedSeason: Int
    var seasonArray: [Season]
    var seriesID: Int
    
    init(seriesID: Int, seasonArray: [Season], selectedSeason: Int) {
        self.seriesID = seriesID
        self.seasonArray = seasonArray
        _selectedSeason = State(initialValue: selectedSeason)
        self.episodeStore = EpisodeStore(with: seriesID)
        UITableView.appearance().backgroundColor = .clear
           UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ZStack {
            ImageView(image: self.seasonArray.filter({$0.number == self.selectedSeason}).first?.image?.original ?? "")
                .blur(radius: 30)
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false){
                    HStack() {
                        ForEach(seasonArray) { season in
                            Button(action: {
                                self.selectedSeason = season.number ?? 0
                            }) {
                                Text(String(season.number ?? 0))
                                    .font(.system(size: 35))
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .background(season.number == self.selectedSeason ? Color.yellow : Color.gray)
                                    .cornerRadius(70/2)
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                }.padding(20)
                
                
                List(episodeStore.episodes.filter({$0.airedSeason == self.selectedSeason})){ episode in
                    EpisodeCell(episode: episode)
                        .listRowBackground(Color.red)
                }
                .listRowBackground(Color.red)
            }
        }
    .navigationBarTitle(Text("Season: \(self.selectedSeason)"))
    }
}


struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        let episodes = ApiMapper().getDummyEpisodes()
        let seasons = ApiMapper().getDummySeasons()
        var view = EpisodeView(seriesID: 1, seasonArray: seasons, selectedSeason: 3)
        let episodeStore = EpisodeStore()
        episodeStore.episodes = episodes
        view.episodeStore = episodeStore
        return view
    }
}

struct EpisodeCell: View {
    var episode: Episode
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(episode.episodeNumber ?? 0). \(episode.episodeName ?? "")")
                .font(.title)
            ImageView(image: episode.image?.original ?? "")
            HStack {
                Text("Run time:")
                    .bold()
                Text("\(episode.runtime ?? 0) hrs")
            }
            HStack(alignment: .top) {
                Text("Summary:")
                    .bold()
                Text(removeTags(from: episode.summary ?? ""))
            }
        }
        .foregroundColor(Color.white)
        .padding(10)
        .background(Color.gray.opacity(0.8))
        .cornerRadius(6)
    }
}
