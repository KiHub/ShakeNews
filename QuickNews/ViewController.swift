//
//  ViewController.swift
//  QuickNews
//
//  Created by  Mr.Ki on 23.03.2022.
//

import UIKit
import SafariServices

//protocol ViewConyrollerDelegate: AnyObject {
//    func didLoadingMainVC()
//}

class ViewController: UIViewController {
    
    
    
    var viewModel = NewsListViewModel()
    //    weak var delegate: ViewConyrollerDelegate?
    
    lazy var headerView: HeaderView = {
        let v = HeaderView(fontSize: 32)
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.tableFooterView = UIView()
        v.register(NewsTableViewCell.self, forCellReuseIdentifier: viewModel.reuseID)
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchNews()
        //       delegate?.didLoadingMainVC()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(tableView)
        setupConstraints()
        setSubHeaderText()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    func  fetchNews() {
        viewModel.getNews { (_) in
            self.tableView.reloadData()
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID, for: indexPath) as? NewsTableViewCell
        let news = viewModel.newsViewModel[indexPath.row]
        cell?.newsViewModel = news
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.newsViewModel[indexPath.row]
        guard let url = URL(string: news.url) else { return }
        let configuration = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: configuration)
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true)
    }
}

extension ViewController {
    
    //    override var canBecomeFirstResponder: Bool {
    //        return true
    //    }
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            Shake.shake.changeCategory()
            fetchNews()
            setSubHeaderText()
            shakeLabel()
            print("Motion detected")
        }
    }
    
    func setSubHeaderText() {
        headerView.subHeaderLine.text = Shake.shake.categoryArray[Shake.shake.categoryNumber]
    }
    
    private func shakeLabel() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 15, -10, 15, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        animation.isAdditive = true
        headerView.subHeaderLine.layer.add(animation, forKey: "shake")
    }
    
}
