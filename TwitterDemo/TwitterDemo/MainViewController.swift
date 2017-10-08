//
//  MainViewController.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/7/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var VCs = [UIViewController]()
    var originalLeftMargin : CGFloat!

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leadingContentViewAttribute: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeNC = storyboard.instantiateViewController(withIdentifier: "HomeNavigationControllerID") as? UINavigationController
        
        if let homeVC = homeNC?.topViewController as? HomeViewController {
            VCs.append(homeVC)
            
            self.addChildViewController(homeVC)
            contentView.addSubview(homeVC.view)
            homeVC.didMove(toParentViewController: self)            
        }
        
        let menuVC = storyboard.instantiateViewController(withIdentifier: "MenuViewControllerID") as! MenuViewController
        
        // Set up menu view
        self.addChildViewController(menuVC)
        menuView.addSubview(menuVC.view)
        menuVC.didMove(toParentViewController: self)
    }
    
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            originalLeftMargin = leadingContentViewAttribute.constant
            
        } else if sender.state == .changed {
            leadingContentViewAttribute.constant = originalLeftMargin + translation.x
            
        } else if sender.state == .ended {
            // moving right
            if velocity.x > 0 {
                UIView.animate(withDuration: 0.3,
                               delay: 0,
                               usingSpringWithDamping: 1.0,
                               initialSpringVelocity: 0,
                               options: .curveEaseInOut,
                               animations: {
                                self.leadingContentViewAttribute.constant = self.view.frame.size.width - 100
                })
            } else {
                // moving left
                UIView.animate(withDuration: 0.3,
                               delay: 0,
                               usingSpringWithDamping: 1.0,
                               initialSpringVelocity: 0,
                               options: .curveEaseInOut,
                               animations: {
                                self.leadingContentViewAttribute.constant = 0
                })
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
    }
    */

}
