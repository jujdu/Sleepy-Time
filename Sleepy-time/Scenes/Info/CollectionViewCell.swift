//
//  CollectionViewCell.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let page = page else { return }
            image.image = UIImage(named: page.imageName)
            presentTextLabel.text = page.text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
//        setupTapGestureForToTimeButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "bear")
        return image
    }()
    
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

    private func setupConstraints() {
        contentView.addSubview(image)
        contentView.addSubview(presentTextLabel)
        
        presentTextLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        presentTextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: presentTextLabel.topAnchor, constant: -10).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
}
