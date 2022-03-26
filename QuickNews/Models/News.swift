//
//  News.swift
//  QuickNews
//
//  Created by  Mr.Ki on 24.03.2022.
//

import Foundation

struct News: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
}

struct NewsEnvelope: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News]
}

//enum category {
//case business
//
//    case entertainment
//    case general
//    case health
//    case science
//    case sports
//    case technology
//}
