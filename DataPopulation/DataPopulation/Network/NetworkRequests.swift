//
//  NetworkRequests.swift
//  DataPopulation
//
//  Created by Valter Louro on 30/09/2024.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
}

protocol PopulationDataProtocol {
    func getPopulationNationList(completionHandler: @escaping (Result<(Any)>) -> Void)
    func getPopulationStateList(completionHandler: @escaping (Result<(Any)>) -> Void)
}

class NetworkRequests: PopulationDataProtocol {
    
    // MARK: Variables
    static let shared = NetworkRequests()
    
    // MARK: Methods
    
    /**
     // General request method
     */
    func request(baseUrl: String, encode: Bool, completionHandler: @escaping (Data) -> Void) {
        
        // Create URL
        let urlToUse: URL?
        
        if encode {
            guard let urlString = baseUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
            
            urlToUse = URL(string: urlString)
            
        } else {
            urlToUse = URL(string: baseUrl)
        }
        
        guard let url = urlToUse else {
            fatalError("Could not create URL")
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            // Check response status is 200 OK
            if let res = response as? HTTPURLResponse {
                if res.statusCode != 200 {
                }
            }
            
            // If returned data is nil
            guard let data = data else {
                return
            }
            
            completionHandler(data)
            
        }).resume()
    }
    
    func getPopulationNationList( completionHandler: @escaping (Result<(Any)>) -> Void) {
        let url = String(format:NetworkConstants.mainUrl, NetworkConstants.nationParameter)
        
        self.request(baseUrl: url, encode: true) { (data) in
            
            do {
                let response = try JSONDecoder().decode(NationApiResponse.self, from: data)
                completionHandler(.success(response))
                
            } catch let jsonErr {
                completionHandler(.error(jsonErr.localizedDescription))
            }
        }
    }
    
    func getPopulationStateList(completionHandler: @escaping (Result<(Any)>) -> Void) {
        let url = String(format:NetworkConstants.mainUrl, NetworkConstants.stateParamter)
        
        self.request(baseUrl: url, encode: true) { (data) in
            
            do {
                let response = try JSONDecoder().decode(StateApiResponse.self, from: data)
                completionHandler(.success(response))
                
            } catch let jsonErr {
                completionHandler(.error(jsonErr.localizedDescription))
            }
        }
    }
    
}
