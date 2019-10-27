//
//  TabbarVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 13/11/2018.
//  Copyright © 2018 Techwisely. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.selectedIndex = 2
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        
        if fromView != toView {
            
            //transitionCrossDissolve
            
            UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let orderedTabBarItemViews: [UIView] = {
            let interactionViews = tabBar.subviews.filter({ $0 is UIControl })
            return interactionViews.sorted(by: { $0.frame.minX < $1.frame.minX })
        }()
        
        guard
            let index = tabBar.items?.firstIndex(of: item),
            let subview = orderedTabBarItemViews[index].subviews.first
            else {
                return
        }
        
        performSpringAnimation(for: subview)
    }
    
    func performSpringAnimation(for view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }, completion: nil)
    }
    
    
}
