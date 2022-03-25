//
//  NewsListViewModel.swift
//  QuickNews
//
//  Created by  Mr.Ki on 25.03.2022.
//

import Foundation

class NewsListViewModel {
    var newsViewModel = [NewsViewModel]()
    let reuseID = "news"
    func getNews(completion: @escaping ([NewsViewModel]) -> Void ) {
        NetworkManager.shared.getNews { (news) in
            guard let news = news else {return}
            let newsViewModel = news.map(NewsViewModel.init)
            DispatchQueue.main.async {
                self.newsViewModel = newsViewModel
                completion(newsViewModel)
            }
        }
    }
}
