//
//  MyScrollView.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 27.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class MyScrollViewVC: UIViewController, UIScrollViewDelegate {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .green
//        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "bear")
        imageView.contentMode = .scaleAspectFill
        return imageView
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
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
//        pageControl.numberOfPages = pages.count
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
    
//    var pages: [Page] = [Page(imageName: "bear", text: "first"), Page(imageName: "bear", text: "second"), Page(imageName: "bear", text: "third"), Page(imageName: "bear", text: "fourth")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupConstraints()
        scrollView.delegate = self
        backgroundImage.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3, height: view.frame.height)
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: view.frame.height)
    }
    
    private func setupConstraints() {
        backgroundImage.fillSuperview()
        scrollView.fillSuperview()
        scrollView.addSubview(backgroundImage)
        view.addSubview(scrollView)
        view.addSubview(stackView)
        


        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    
    
}
