//
//  NetworkManager.swift
//  test_work
//
//  Created by Владислав Шушпанов on 10.08.2021.
//


import Foundation
import UIKit

class NetworkManager {
    
    
    func downloudJSON(completionHandler: @escaping(JSONData) -> Void) {
        let urlString = "https://pryaniky.com/static/json/sample.json"
        let url = URL(string: urlString)
        let sessoin = URLSession(configuration: .default)
        guard let url = url else { return }
        let task = sessoin.dataTask(with: url) { data, response, Error in
            if let data = data {
                guard let dataJSON = self.parseJSON(data: data) else { return }
                completionHandler(dataJSON)
            }
        }
        
        task.resume()
    }
    
    func downloudImage(urlString: String, completionHandler: @escaping(UIImage) -> Void) {
        let url = URL(string: urlString)
        let sessoin = URLSession(configuration: .default)
        guard let url = url else { return }
        let task = sessoin.dataTask(with: url) { data, response, Error in
            if let data = data {
                guard let image = UIImage(data: data) else { return }
                completionHandler(image)
            }
        }
        task.resume()
    }
    
    func parseJSON(data: Data) -> JSONData? {
        let decoder = JSONDecoder()
        do {
            let JsonData = try decoder.decode(JSONData.self, from: data)
            return JsonData
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
  
}
