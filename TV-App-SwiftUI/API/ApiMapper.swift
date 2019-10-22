
//
//  ApiMapper.swift
//  TV App
//
//  Created by JK on 07/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//
import UIKit

class ApiMapper {
    
    //MARK: Series list API

    
    func getSeries(with pageNumber: Int = 1, andCallback callback: @escaping (Result<[Series], Error>) -> Void) {
        
        let params = [
            ("page", String(pageNumber))
        ]
        self.callAPI(withPath: AppData.show, params: params, andMappingModel: [Series].self) {  (result) in
            callback(result)
        }
    }
    
    
    func getSeasons(with seriesID: Int, andCallback callback: @escaping (Result<[Season], Error>) -> Void) {
        
        let path = "\(AppData.shows)\(seriesID )\(AppData.season)"
        self.callAPI(withPath: path, params: [], andMappingModel: [Season].self) { (result) in
           callback(result)
        }
    }
    
    func getEpisodes(with seriesID: Int, andCallback callback: @escaping (Result<[Episode], Error>) -> Void) {
        
        let path = "\(AppData.shows)\(seriesID)\(AppData.episodes)"
        self.callAPI(withPath: path, params: [], andMappingModel: [Episode].self) { (result) in
           callback(result)
        }
    }
    
    
    //MARK: Dummy data
    
    func getDummySeries() -> [Series] {
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
    
    
    func getDummySeasons() -> [Season] {
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
    
    func getDummyEpisodes() -> [Episode] {
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

    
    //MARK: Api Calls
    
    private func callAPI<T: Codable>(withPath pathString: String, params : [(String, String)], andMappingModel model: T.Type, callback: @escaping (Result<T, Error>) -> Void ) {
        
        let url = self.generateURL(withPath: pathString , andParams: [])
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(model, from: data!)
                 callback(Result.success(responseModel))
            } catch {
                callback(Result.failure(error))
            }
        }
        task.resume()
    }
    
    //MARK: helper methods
    
   private func generateURL(withPath path: String, andParams params: [(String, String)]) -> URL {
        
        var urlComp = URLComponents(string: AppData.baseUrl)!
        for param in params {
            urlComp.queryItems?.append(URLQueryItem(name: param.0, value: param.1))
        }
        var url = urlComp.url!
        url = url.appendingPathComponent(path)
        return url
    }
}
