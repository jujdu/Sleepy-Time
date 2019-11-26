//
//  PageViewController.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 25.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
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
