//
//  SampleAPIResult.swift
//  TV-App-SwiftUI
//
//  Created by Jayakrishnan M on 23/10/19.
//  Copyright © 2019 ltrix. All rights reserved.
//

import Foundation

struct SampleAPIResult {
    
    //MARK: Dummy data
    
    static func getDummySeries() -> [Series] {
        if let path = Bundle.main.path(forResource: "show", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([Series].self, from: data)
                return responseModel
            } catch {
            }
        }
        return []
    }
    
    
    static func getDummySeasons() -> [Season] {
        if let path = Bundle.main.path(forResource: "seasons", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([Season].self, from: data)
                return responseModel
            } catch {
            }
        }
        return []
    }
    
    static func getDummyEpisodes() -> [Episode] {
        if let path = Bundle.main.path(forResource: "episodes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([Episode].self, from: data)
                return responseModel
            } catch {
            }
        }
        return []
    }
    
    
    static func getDummyCasts() -> [CastCrew] {
        if let path = Bundle.main.path(forResource: "cast", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode([CastCrew].self, from: data)
                return responseModel
            } catch {
            }
        }
        return []
    }
    
    static func getDummyCrew() -> [CastCrew] {
          if let path = Bundle.main.path(forResource: "crew", ofType: "json") {
              do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonDecoder = JSONDecoder()
                  let responseModel = try jsonDecoder.decode([CastCrew].self, from: data)
                  return responseModel
              } catch {
              }
          }
          return []
      }
}
