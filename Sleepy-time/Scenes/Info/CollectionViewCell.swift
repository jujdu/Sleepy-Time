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
    
    //MARK: - Views
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        //        image.image = #imageLiteral(resourceName: "bear")
        return image
    }()
    
    lazy private var presentTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemPink
        label.textAlignment = .center
        label.font = UIFont(name: AppFonts.avenirHeavy, size: 17)
        label.numberOfLines = 1
        return label
    }()
    
    lazy private var myButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK, I understood. Let me sleep!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    
    @objc func myButtonTapped() {
        delegate?.dismissButtonPressed()
    }
    
    //MARK: - Properties
    var page: Page? {
        didSet {
            guard let page = page else { return }
            setupConstraints()
            image.backgroundColor = page.color
            presentTextLabel.text = page.text
            if page.isButtonActive {
               setupButtonConstraints()
            }
        }
    }
    
    var delegate: CollectionViewCellDelegate?
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupConstraints()
        contentView.backgroundColor = .clear
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        presentTextLabel.text = nil
        image.backgroundColor = nil
        myButton.removeFromSuperview()
    }
    
    //MARK: - User functions
    private func setupConstraints() {
        contentView.addSubview(image)
        contentView.addSubview(presentTextLabel)
        
//        image.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        presentTextLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
        presentTextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    private func setupButtonConstraints() {
        contentView.addSubview(myButton)
        myButton.topAnchor.constraint(equalTo: presentTextLabel.bottomAnchor, constant: 20).isActive = true
        myButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        myButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
