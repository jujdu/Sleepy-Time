//
//  CollectionViewCell.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate {
    func dismissButtonPressed()
}

class CollectionViewCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let page = page else { return }
            image.backgroundColor = page.color
//            image.image = UIImage(named: page.imageName)
            presentTextLabel.text = page.text
//            if page.isButtonActive {
//                contentView.addSubview(myButton)
//                myButton.topAnchor.constraint(equalTo: presentTextLabel.bottomAnchor, constant: 20).isActive = true
//                myButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//            }
        }
    }
    var delegate: CollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        contentView.backgroundColor = .clear
        setupTapGestureForMyButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.image = #imageLiteral(resourceName: "bear")
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

    private func setupConstraints() {
        contentView.addSubview(image)
        contentView.addSubview(presentTextLabel)

        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        presentTextLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
        presentTextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
        func setupTapGestureForMyButton() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(myButtonTapped))
            myButton.addGestureRecognizer(tapGesture)
        }
    
        @objc func myButtonTapped() {
            delegate?.dismissButtonPressed()
        }
    
    
}
