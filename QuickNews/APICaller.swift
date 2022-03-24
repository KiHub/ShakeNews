//
//  APICaller.swift
//  QuickNews
//
//  Created by  Mr.Ki on 24.03.2022.
//

//import Foundation
//
//final class APICaller {
//    static let shared = APICaller()
//    
//    struct Constants {
//        static let topNewsUrl = URL(string: "https://newsapi.org/v2/top-headlines?language=en&apiKey=88aaae2339764dc2be1d77f32e52333b")
//    }
//    
//    private init() {}
//    
//    public func getTopNews(completion: @escaping (Result<[String], Error>) -> Void) {
//        guard let url = Constants.topNewsUrl else {
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                completion(.failure(error))
//            }
//            else if let data = data {
//                do {
//                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
//                    print(result.articles.count)
//                }
//                catch {
//                    completion(.failure(error))
//                }
//            }
//        }
//        task.resume()
//    }
//}
