//
//  NetworkService.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 17.01.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Alamofire
import UIKit

public class NetworkService {
    
    public func fetchTracks(searchText: String, completion: @escaping (SearchResponse?) -> ()) {
        let url = FeatureList().featureFlag.musicUrl
        let limit = FeatureList().featureFlag.itemsLimitCount
        let parameters = ["term": searchText,
                          "limit": limit]
        
        AF.request(url, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error recieved reuesting data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                completion(objects)
                
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(nil)
            }
        }
    }
}
