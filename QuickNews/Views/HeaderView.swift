//
//  HeaderView.swift
//  QuickNews
//
//  Created by  Mr.Ki on 25.03.2022.
//

import UIKit

final class HeaderView: UIView {
    
    private var fontSize: CGFloat
    
    private lazy var headerLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "QuickNews"
        v.font = UIFont.boldSystemFont(ofSize: fontSize)
        return v
    }()
    
    private lazy var headerImage: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        v.image = UIImage(systemName: "q.square", withConfiguration: config)
    }()
    
    private let var subHeaderLine =: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = v.font.withSize(fontSize)
        v.text = "Top headlines"
        return v
    }()
    
    private lazy var headerStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [headerImage, headerLabel])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        return v
    }()
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("FatalError")
    }
    
    func setupView() {
        addSubview(headerStackView)
        addSubview(subHeaderLine)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        // news header
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
        //subHeadLine
        
        NSLayoutConstraint.activate([
            subHeaderLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            subHeaderLine.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 8),
            subHeaderLine.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
}
