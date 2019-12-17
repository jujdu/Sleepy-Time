//
//  SwipingViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 26.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class SwipingViewController: UIViewController {
    //MARK: - Collection View
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
        imageView.image = UIImage(named: "stars1")
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
        imageView.alpha = 0.6
        return imageView
    }()
    
    let cloudBG2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "cloudBG1")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.alpha = 0.7
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
        button.setTitleColor(.systemPink, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2784313725, alpha: 1), for: .disabled)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    @objc private func handlePrevious() {
        let currentPage = max(pageControl.currentPage - 1, 0)
        self.currentPage = currentPage
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2784313725, alpha: 1), for: .disabled)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext() {
        let currentPage = min(pageControl.currentPage + 1, pages.count - 1)
        self.currentPage = currentPage
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .systemPink
        pageControl.numberOfPages = pages.count
        return pageControl
    }()
    
    //MARK: - Properties
    var pages: [Page] = [
            Page(imageName: "bear", text: "first", isButtonActive: false, color: .yellow),
            Page(imageName: "bear", text: "second", isButtonActive: false, color: .orange),
            Page(imageName: "bear", text: "third", isButtonActive: false, color: .red),
            Page(imageName: "bear", text: "fourth", isButtonActive: true, color: .green)
    ]
    
    private var currentPage: Int = 0 {
        willSet {
            guard currentPage != newValue else { return }
            pageControl.currentPage = newValue
            setButtonsStatusDependsOnControl(newValue: newValue)
            doVibration()
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionView.collectionViewLayout.invalidateLayout()
            let xOffset = self.view.frame.width * CGFloat(self.currentPage)
            self.collectionView.contentOffset = CGPoint(x: xOffset, y: 0)
//            let indexPath = IndexPath(item: self.currentPage, section: 0)
//            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true) //same
        }, completion: nil)
    }
    
    private func setupConstraints() {
        //MARK: - Setup Back Views
        view.addSubview(pictureBG)
        view.addSubview(cloudBG2)
        view.addSubview(cloudBG1)
        
        pictureBG.bgAnchor(to: view)
        cloudBG2.bgAnchor(to: view)
        cloudBG1.bgAnchor(to: view)
        
        //MARK: - Setup Front Views
        view.addSubview(collectionView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(nextButton)
        
        collectionView.fillSuperview()
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func doVibration() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func setButtonsStatusDependsOnControl(newValue: Int) {
        if newValue == 0 {
            previousButton.isEnabled = false
        } else if newValue == pages.count - 1 {
            nextButton.isEnabled = false
        } else {
            previousButton.isEnabled = true
            nextButton.isEnabled = true
        }
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        handleCurrentPage(for: scrollView)
        
        generateHorizontalScrollAnimation(to: pictureBG, dependencyOn: scrollView, value: 0.07)
        generateHorizontalScrollAnimation(to: cloudBG1, dependencyOn: scrollView, value: 0.08)
        generateHorizontalScrollAnimation(to: cloudBG2, dependencyOn: scrollView, value: 0.06)
    }
    
    private func handleCurrentPage(for scrollView: UIScrollView) {
        let xOffset = scrollView.contentOffset.x
        let width = view.frame.width
        let halfWidth = width / 2
        let cPage = CGFloat(currentPage)

        if scrollView.isTracking || scrollView.isDragging {
            if xOffset <= (width * cPage) - halfWidth && currentPage != 0 {
                currentPage -= 1
            } else if xOffset >= (width * cPage) + halfWidth && currentPage != pages.count - 1 {
                currentPage += 1
            }
        }
    }
    
    private func generateHorizontalScrollAnimation(to view: UIView, dependencyOn scrollView: UIScrollView, value: CGFloat) {
        let xOffset = scrollView.contentOffset.x * value
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











//        if xOffset < viewWidth / 2 {
//            currentPage = 0
//        } else if xOffset >= viewWidth / 2
//&& xOffset < viewWidth + (viewWidth / 2) {
//            currentPage = 1
//        } else if xOffset >= (viewWidth * 1) + (viewWidth / 2)
//&& xOffset < (viewWidth * 2) + (viewWidth / 2) {
//            currentPage = 2
//        } else if xOffset >= (viewWidth * 2) + (viewWidth / 2) {
//            currentPage = 3
//        }
//           } else if xOffset >= (width * cPage) + halfWidth{ // 400 * 1 + 200 -> 1 page
//        //               && xOffset < (width * (cPage + 1)) + halfWidth { //(400 * 2) + 200
//
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        coordinator.animate(alongsideTransition: { (_) in
//            self.collectionView.collectionViewLayout.invalidateLayout()
//            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
//            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
////            if self.pageControl.currentPage == 0 {
////                self.collectionView.contentOffset = .zero
////            } else {
////
////            }
//        }, completion: nil)
//
//    }
