//
//  PageViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 25.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    //MARK: - Stack View
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        return stackView
    }()
    
    private var previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl.appearance()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    
    var pages: [Page] = [Page(imageName: "bear", text: "first", isButtonActive: false, color: .yellow), Page(imageName: "bear", text: "second", isButtonActive: false, color: .orange), Page(imageName: "bear", text: "third", isButtonActive: false, color: .red), Page(imageName: "bear", text: "fourth", isButtonActive: true, color: .green)]
    var currentIndex: Int!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        dataSource = self

        let infoViewController = showInfoViewController(currentIndex ?? 0)
        setViewControllers([infoViewController], direction: .forward, animated: true, completion: nil)
        setupConstraints()
    }
    
    private func showInfoViewController(_ index: Int) -> InfoViewController {
        let infoViewController = InfoViewController()
        infoViewController.page = pages[index]
        infoViewController.pageIndex = index
        return infoViewController
    }
    
    private func setupConstraints() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(nextButton)

        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
           if let viewController = viewController as? InfoViewController, let index = viewController.pageIndex, index > 0 {
            return showInfoViewController(index - 1)
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? InfoViewController, let index = viewController.pageIndex, (index + 1) < pages.count {
            return showInfoViewController(index + 1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
      return pages.count
    }
      
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
      return currentIndex ?? 0
    }
    
    
}
