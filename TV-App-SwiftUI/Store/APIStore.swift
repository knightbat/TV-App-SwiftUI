//
//  APIStore.swift
//  TV-App-SwiftUI
//
//  Created by Jayakrishnan M on 17/10/19.
//  Copyright © 2019 ltrix. All rights reserved.
//

import SwiftUI
import Combine

enum APIType {
    case listSeries
    case listseasons
    case listEpisodes
    case listCast
    case listCrew
}

class APIStore: ObservableObject {
    
    @Published var serieses: [Series] = []
    @Published var seasons: [Season] = []
    @Published var episodes: [Episode] = []
    @Published var casts: [CastCrew] = []
    @Published var crews: [CastCrew] = []

    
    
    init() {
        serieses = []
        seasons = []
        episodes = []
        casts = []
        crews = []
    }
    
    func fetchSeries(pageNumber: Int = 1)  {
        
        let params = [
            ("page", String(pageNumber))
        ]
        ApiMapper().callAPI(withPath: AppData.show, params: params, andMappingModel: [Series].self) { [weak self] (result) in
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
    
    
    func searchSeries(searchString: String)  {
           
           let params = [
               ("q", searchString)
           ]
           ApiMapper().callAPI(withPath: AppData.search, params: params, andMappingModel: [SearchResult].self) { [weak self] (result) in
               switch(result) {
               case .success(let searchResult):
                   DispatchQueue.main.async {
                    self?.serieses = searchResult.compactMap({$0.series})
                   }
               case .failure(_):
                   break
               }
           }
       }
    
    
    func fetchSeason(with seriesID: Int)  {
        
        let path = "\(AppData.shows)\(seriesID)\(AppData.season)"
        ApiMapper().callAPI(withPath: path, params: [], andMappingModel: [Season].self) { [weak self] (result) in
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
    
    func fetchEpisodes(with seriesID: Int)  {
        let path = "\(AppData.shows)\(seriesID)\(AppData.episodes)"
        
        ApiMapper().callAPI(withPath: path, params: [], andMappingModel: [Episode].self) { [weak self] (result) in
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
    
    func fetchCasts(with seriesID: Int)  {
         let path = "\(AppData.shows)\(seriesID)\(AppData.cast)"

         ApiMapper().callAPI(withPath: path, params: [], andMappingModel: [CastCrew].self) { [weak self] (result) in
             switch(result) {
             case .success(let casts):
                 DispatchQueue.main.async {
                     self?.casts = casts
                 }
             case .failure(_):
                 break
             }
         }
     }
    
    func fetchCrews(with seriesID: Int)  {
         let path = "\(AppData.shows)\(seriesID)\(AppData.crew)"

         ApiMapper().callAPI(withPath: path, params: [], andMappingModel: [CastCrew].self) { [weak self] (result) in
             switch(result) {
             case .success(let casts):
                 DispatchQueue.main.async {
                     self?.crews = casts
                 }
             case .failure(_):
                 break
             }
         }
     }
}
