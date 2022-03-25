//
//  ViewController.swift
//  QuickNews
//
//  Created by  Mr.Ki on 23.03.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        NetworkManager.shared.getNews { (news) in
//            guard let news = news else {return}
//            print(news[0].title)
//        }
        NetworkManager.shared.getNews { (news) in
            guard let news = news else { return }
            print(news.first?.title ?? "Error")
        }
        
    }
    

}

