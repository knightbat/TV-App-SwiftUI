
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
    
    func callAPI<T: Codable>(withPath pathString: String, params : [(String, String)], andMappingModel model: T.Type) async -> (Result<T, Error>) {
        
        if let url = self.generateURL(withPath: pathString , andParams: params) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(model, from: data)
                return Result.success(responseModel)
            } catch {
                return (Result.failure(URLError(.badServerResponse)))
            }
        } else {
            return Result.failure(URLError(.badURL))
        }
    }
    
    //MARK: helper methods
    
    private func generateURL(withPath path: String, andParams params: [(String, String)]) -> URL? {
        
        guard var urlComp = URLComponents(string: AppData.baseUrl) else {return nil}
        urlComp.queryItems = [URLQueryItem]()
        for param in params {
            urlComp.queryItems?.append(URLQueryItem(name: param.0, value: param.1))
        }
        guard var  url = urlComp.url else {return nil}
        url = url.appendingPathComponent(path)
        return url
    }
}
