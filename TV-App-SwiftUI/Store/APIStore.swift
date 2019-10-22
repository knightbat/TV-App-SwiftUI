//
//  APIStore.swift
//  TV-App-SwiftUI
//
//  Created by Jayakrishnan M on 17/10/19.
//  Copyright © 2019 ltrix. All rights reserved.
//

import SwiftUI
import Combine

class SeriesStore: ObservableObject {
    
    @Published var serieses: [Series] = [Series]()
    
    init() {
        fetchSeries()
    }
    private func fetchSeries()  {
        ApiMapper().getSeries { [weak self] (result) in
            switch(result) {
            case .success(let serieses):
                DispatchQueue.main.async {
                    self?.serieses = serieses
                }
            case .failure(_):
                break
            }
        }
    }
}


class SeasonStore: ObservableObject {
    
    @Published var seasons: [Season] = [Season]()
    
    init(with id: Int = 0) {
        guard id != 0 else { return }
        fetchSeason(with: id)
    }
    
    private func fetchSeason(with id: Int)  {
        ApiMapper().getSeasons(with: id) { [weak self] (result) in
            switch(result) {
            case .success(let seasons):
                DispatchQueue.main.async {
                    self?.seasons = seasons
                }
            case .failure(_):
                break
            }
        }
    }
}


class EpisodeStore: ObservableObject {
    
    @Published var episodes: [Episode] = [Episode]()
    
    init(with id: Int = 0) {
        guard id != 0 else { return }
        fetchEpisodes(with: id)
    }
    
    private func fetchEpisodes(with id: Int)  {
        ApiMapper().getEpisodes(with: id) { [weak self] (result) in
            switch(result) {
            case .success(let episodes):
                DispatchQueue.main.async {
                    self?.episodes = episodes
                }
            case .failure(_):
                break
            }
        }
    }
}
