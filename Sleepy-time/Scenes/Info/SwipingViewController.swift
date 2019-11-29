//
//  SwipingViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class SwipingViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        return collectionView
    }()
    
    //MARK: - Back Views
    let pictureBG: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "pictureBG")
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    let cloudBG1: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "cloudBG")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        //        imageView.alpha = 0.8
        return imageView
    }()
    
    let cloudBG2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "cloudBG1")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.alpha = 0.8
        return imageView
    }()
    
    //MARK: - Bottom Stack View
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
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrevious() {
        currentPage = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: currentPage, section: 0)
        pageControl.currentPage = currentPage
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext() {
        currentPage = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: currentPage, section: 0)
        pageControl.currentPage = currentPage
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.numberOfPages = pages.count
        return pageControl
    }()
    
    //MARK: - Properties
    var pages: [Page] = [Page(imageName: "bear", text: "first", isButtonActive: false, color: .yellow), Page(imageName: "bear", text: "second", isButtonActive: false, color: .orange), Page(imageName: "bear", text: "third", isButtonActive: false, color: .red), Page(imageName: "bear", text: "fourth", isButtonActive: true, color: .green)]
    
    var currentPage: Int = 0 {
        willSet {
            if currentPage != newValue {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
           
            }
        }
    }
    
    //MARK: - Lify cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionView.collectionViewLayout.invalidateLayout()
            if self.pageControl.currentPage == 0 {
                self.collectionView.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }, completion: nil)
        
    }
    
    private func setupConstraints() {
        //MARK: - Setup Back Views
        view.addSubview(pictureBG)
        view.addSubview(cloudBG2)
        view.addSubview(cloudBG1)
        
        pictureBG.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor,
                         padding: UIEdgeInsets(top: 0, left: -200, bottom: 0, right: -200),
                         size: .zero)
        cloudBG2.anchor(top: view.topAnchor,
                        leading: view.leadingAnchor,
                        bottom: view.bottomAnchor,
                        trailing: view.trailingAnchor,
                        padding: UIEdgeInsets(top: 0, left: -200, bottom: 0, right: -200),
                        size: .zero)
        cloudBG1.anchor(top: view.topAnchor,
                        leading: view.leadingAnchor,
                        bottom: view.bottomAnchor,
                        trailing: view.trailingAnchor,
                        padding: UIEdgeInsets(top: 0, left: -200, bottom: 0, right: -600),
                        size: .zero)
        
        view.addSubview(collectionView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(nextButton)
        
        collectionView.fillSuperview()
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func makeVibro() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

//MARK: - CollectionViewDelegate
extension SwipingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CollectionViewCell
        cell.page = pages[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//MARK: - ScrollViewDelegate
extension SwipingViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        generateHorizontalScrollAnimation(to: pictureBG, in: scrollView, velocity: 0.1)
        generateHorizontalScrollAnimation(to: cloudBG1, in: scrollView, velocity: 0.2)
        generateHorizontalScrollAnimation(to: cloudBG2, in: scrollView, velocity: 0.3)
    }
    
    private func generateHorizontalScrollAnimation(to view: UIView, in scrollView: UIScrollView, velocity: CGFloat) {
        let xOffset = scrollView.contentOffset.x * velocity
        let contentRectXOffset = xOffset / view.frame.size.width
        view.layer.contentsRect = CGRect(x: contentRectXOffset, y: 0, width: 1, height: 1)
    }
}

//MARK: - CollectionViewCellDelegate
extension SwipingViewController: CollectionViewCellDelegate {
    func dismissButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
