//
//  NewsViewModel.swift
//  QuickNews
//
//  Created by  Mr.Ki on 25.03.2022.
//

import Foundation

struct NewsViewModel {
    let news: News
    
    var author: String {
        return news.author ?? "Unknown"
    }
    
    var title: String {
        return news.title ?? ""
    }
    
    var url: String {
        return news.url ?? ""
    }
    
    var urlToImage: String {
        return news.urlToImage ?? "https://miro.medium.com/max/978/1*pUEZd8z__1p-7ICIO1NZFA.png"
    }
}
