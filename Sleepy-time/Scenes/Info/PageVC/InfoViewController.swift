//
//  InfoViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 25.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    let topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "bear")
        return image
    }()
    
    lazy private var presentTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
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

    //MARK: - Properties
    var page: Page? {
        didSet {
            guard let page = page else { return }
            image.image = UIImage(named: page.imageName)
            presentTextLabel.text = page.text
        }
    }
    var pageIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        setupTapGestureMyButton()
    }

    private func setupConstraints() {
        view.addSubview(presentTextLabel)
        presentTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        presentTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if pageIndex == 3 {
            view.addSubview(myButton)
            myButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }

    }
    
    func setupTapGestureMyButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(myButtonTapped))
        myButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func myButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
