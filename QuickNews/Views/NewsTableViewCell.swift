//
//  NewsTableViewCell.swift
//  QuickNews
//
//  Created by  Mr.Ki on 25.03.2022.
//

import UIKit

final class  NewsTableViewCell: UITableViewCell {
    
    let group = DispatchGroup()
    
    var newsViewModel: NewsViewModel? {
        didSet {
            group.enter()
            if let newsViewModel = newsViewModel {
                titleLabel.text = newsViewModel.title
                NetworkManager.shared.getImage(urlString: newsViewModel.urlToImage) { (data) in
                    guard let data = data else {return}
                   // DispatchQueue.main.async {
                    self.group.notify(queue: .main) {
                        self.newsImage.image = UIImage(data: data)
                    }
                }
            }
            group.leave()
        }
    }
    var newsImageData: Data? {
        didSet {
            group.enter()
            if let data = newsImageData {
                newsImage.image = UIImage(data: data)
            }
            group.leave()
        }
    }
    private lazy var newsImage: ShadowImageView = {
        let v = ShadowImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(newsImage)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImage.topAnchor.constraint(equalTo: topAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
    }
}
