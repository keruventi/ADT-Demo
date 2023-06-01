//
//  NetworkService.swift
//  ADT-Demo
//
//  Created by Karnakar Eruventi on 6/1/23.
//

import Foundation

enum NetworkError: Error {
    case FAILED
    case DECODE_ERROR
}

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    fileprivate var baseUrl = "https://rickandmortyapi.com/api/episode"
    //typealias handler = (Result<Episode, Error>) -> Void
    
    
    func fetchData<T: Codable>(type: T.Type, urlString: String? = nil, completionHandler: @escaping ((Result<T, Error>) -> Void)) {
        //Code for network call - Urlsession
        
        if let urlString = urlString {
            baseUrl = urlString
        }
        
        guard let url = URL(string: baseUrl) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                //return error response
                print("Failed fetching data from server", error.localizedDescription)
                DispatchQueue.main.async {
                    completionHandler(.failure(NetworkError.FAILED))
                }
            } else {
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(result))
                    }
                } catch(let error) {
                    print("Decoding error", error.localizedDescription)
                    DispatchQueue.main.async {
                        completionHandler(.failure(NetworkError.DECODE_ERROR))
                    }
                }
                
            }
            
        }
        
        task.resume()
    }
}
