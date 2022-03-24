//
//  NetworkManager.swift
//  QuickNews
//
//  Created by  Mr.Ki on 24.03.2022.
//

import Foundation

class NetworkManager {
    let imageCache = NSCache<NSString, NSData>()
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseUrlString = "https://newsapi.org/v2/"
    private let topHeadline = "top-headlines?language=en"
    
    func getNews(completion: @escaping([News]?) -> Void) {
        let urlString = "\(baseUrlString)\(topHeadline)&apiKey=\(APIKey.key)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            let newEnvelope = try? JSONDecoder().decode(NewsEnvelope.self, from: data)
            newEnvelope == nil ? completion(nil) : completion(newEnvelope!.articles)
        }.resume()
    }
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else { return
            completion(nil)
            return
        }
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            URLSession.shared.dataTask(with: url) { ( data, response, error) in
                guard error == nil, let data = data else {
                completion(nil)
                return
            }
            self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
            completion(data)
        }.resume()
        }
    }
}
