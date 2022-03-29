//
//  OnboardingContainerViewController.swift
//  ShakeNews
//
//  Created by  Mr.Ki on 29.03.2022.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let closeButton = UIButton(type: .system)
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(heroImageName: "person1", titleText: "ShakeNews is brand new app. We provide fresh news. Every day")
        let page2 = OnboardingViewController(heroImageName: "person2", titleText: "Interesting something else? Just shake your phone to change the news category")
        let page3 = OnboardingViewController(heroImageName: "person3", titleText: "Just shake and read")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
        
    }
    
    private func setup() {
        view.backgroundColor = .systemGray5
        //MARK: - Load and sutup pageVC
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        //MARK: - Delegate
        pageViewController.dataSource = self
        //MARK: - Turn off auto constaraints
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
    private func style() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.tintColor = .black
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        
        view.addSubview(closeButton)
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: closeButton.trailingAnchor, multiplier: 4),
        //    closeButton.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4)
        ])
        
    }
    
}

// MARK: - UIPageViewControllerDataSource, swipe logic
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

//MARK: - Actions

extension OnboardingContainerViewController {
    @objc func closeTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
        print("Close tapped")
    }
}
