//
//  PageViewController.swift
//  Budget-App
//
//  Created by Joshua Fraser on 2/17/18.
//  Copyright © 2018 Joshua Fraser. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}

// MARK: UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,                       viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}

private var orderedViewControllers: [UIViewController] = {
    return [UIStoryboard(name: "Main", bundle: nil) .
        instantiateViewController(withIdentifier: "Expenses"),
            UIStoryboard(name: "Main", bundle: nil) .
        instantiateViewController(withIdentifier: "Bills")]
}()

/*private func newColoredViewController(color: String) -> UIViewController {
    return UIStoryboard(name: "Main", bundle: nil) .
        instantiateViewController(withIdentifier: "\(color)ViewController")
} */
