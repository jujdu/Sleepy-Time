//
//  PageViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 25.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    lazy private var myButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK, I understood. Let me sleep!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    
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
        let pageControl = UIPageControl()
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
    
    let presentScreenContent = [
        "First",
        "Second",
        "Third",
        "Fourth",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let contentViewController = showViewController(at: 0) {
            setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        }
        
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        setupConstraints()

    }
    
    private func setupConstraints() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(nextButton)
        
//        if currentPage == 3 {
//            view.addSubview(myButton)
//            myButton.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -30).isActive = true
//            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            myButton.heightAnchor.constraint(equalToConstant: Constraints.buttonHeight).isActive = true
//        }
        
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setupTapGestureForToTimeButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(myButtonTapped))
        myButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func myButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func showViewController(at index: Int) -> InfoViewController? {
        guard index >= 0 else { return nil }
        print(index)
        guard index <  presentScreenContent.count else { return nil }
        let contentViewController = InfoViewController()
        contentViewController.presentText = presentScreenContent[index]
        contentViewController.numberOfPages = presentScreenContent.count
        contentViewController.currentPage = index
        return contentViewController
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! InfoViewController).currentPage
        pageNumber -= 1
        return showViewController(at: pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! InfoViewController).currentPage
        pageNumber += 1
        return showViewController(at: pageNumber)
    }
    
    
}
