
//
//  ApiMapper.swift
//  TV App
//
//  Created by JK on 07/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//
import UIKit

class ApiMapper {
    
    //MARK: Api Calls
    
    func callAPI<T: Codable>(withPath pathString: String, params : [(String, String)], andMappingModel model: T.Type, callback: @escaping (Result<T, Error>) -> Void ) {
        
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
