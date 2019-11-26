//
//  InfoViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 25.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    lazy private var presentTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            // Fallback on earlier versions
        }
        label.text = "hello"
        label.textAlignment = .center
        label.font = UIFont(name: AppFonts.avenirBook, size: 17)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

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

    //MARK: - Properties
    var presentText = ""
    var emojiText = ""
    var currentPage = 0
    var numberOfPages = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        setupConstraints()
//        setupTapGestureForToTimeButton()
        presentTextLabel.text = presentText
//        pageControl.numberOfPages = numberOfPages
//        pageControl.currentPage = currentPage
    }

    private func setupConstraints() {
        view.addSubview(presentTextLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(nextButton)
        
        presentTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        presentTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if currentPage == 3 {
            view.addSubview(myButton)
            myButton.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -30).isActive = true
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            myButton.heightAnchor.constraint(equalToConstant: Constraints.buttonHeight).isActive = true
        }
        
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

}
