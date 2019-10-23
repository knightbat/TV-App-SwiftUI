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
    
    init(with type: APIType) {
        
        switch type {
        case .listSeries:
            fetchSeries()
        case .listseasons, .listEpisodes, .listCast:
            print("wrong init method")
        @unknown default:
            print("Not implemented")
        }
        
    }
    
    init(with id: Int, type:  APIType) {
        guard id != 0 else { return }
        
        switch type {
        case .listseasons:
            fetchSeason(with: id)
        case .listEpisodes:
            fetchEpisodes(with: id)
        case .listCast:
            fetchCasts(with: id)
        case .listSeries:
            print("Wrong init method")
        
            
        @unknown default:
            print("Not implemented")
            
        }
        
    }
    
    private func fetchSeries(pageNumber: Int = 1)  {
        
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
    
    private func fetchSeason(with id: Int)  {
        
        let path = "\(AppData.shows)\(id)\(AppData.season)"
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
    
    private func fetchEpisodes(with id: Int)  {
        let path = "\(AppData.shows)\(id)\(AppData.episodes)"
        
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
    
    private func fetchCasts(with id: Int)  {
         let path = "\(AppData.shows)\(id)\(AppData.cast)"

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
}
