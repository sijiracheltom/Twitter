//
//  MainViewController.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/7/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MenuViewControllerDelegate {
    var VCsDict = [MenuOptions : UIViewController]()
    var originalLeftMargin : CGFloat!
    var currentContentVC : UIViewController!

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leadingContentViewAttribute: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        // Home time line VC
        let homeNC = storyboard.instantiateViewController(withIdentifier: "HomeNavigationControllerID") as? UINavigationController
        
        if let homeVC = homeNC?.topViewController as? HomeViewController {
            let homeOption = MenuOptions.timeLine
            
            VCsDict[homeOption] = homeVC
            
            self.addChildViewController(homeVC)
            contentView.addSubview(homeVC.view)
            homeVC.didMove(toParentViewController: self)
            
            currentContentVC = homeVC
            navigationItem.title = stringify(menuOption: homeOption)
        }
        
        // Profile VC
        let homeNC1 = storyboard.instantiateViewController(withIdentifier: "HomeNavigationControllerID") as? UINavigationController
        
        if let homeVC1 = homeNC1?.topViewController as? HomeViewController {
            VCsDict[MenuOptions.profile] = homeVC1
        }
        
        let menuVC = storyboard.instantiateViewController(withIdentifier: "MenuViewControllerID") as! MenuViewController
        menuVC.delegate = self
        
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
            let newLeftMargin = originalLeftMargin + translation.x
            if newLeftMargin > 0 {
                leadingContentViewAttribute.constant = newLeftMargin
            }
            
        } else if sender.state == .ended {
            // moving right
            if velocity.x > 0 {
                animate(toOrigin: false)
            } else {
                // moving left
                animate(toOrigin: true)
            }
        }
    }
    
    func animate(toOrigin : Bool) -> Void {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0,
                       options: .curveEaseIn,
                       animations: {
                        if toOrigin {
                            self.leadingContentViewAttribute.constant = 0
                        } else {
                            self.leadingContentViewAttribute.constant = self.view.frame.size.width - 100
                        }
                        
                        self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func onSignOut(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    @IBAction func onCompose(_ sender: Any) {
        self.performSegue(withIdentifier: "TweetComposeSegueID", sender: nil)
    }
    
    // MARK:- MenuViewControllerDelegate
    
    func menuViewController(_menuViewController: MenuViewController, didSelectOption option: MenuOptions) {
        let VC = VCsDict[option]
        
        if let VC = VC {
            if let currentContentVC = currentContentVC {
                currentContentVC.willMove(toParentViewController: nil)
                currentContentVC.removeFromParentViewController()
            }
            
            self.addChildViewController(VC)
            contentView.addSubview(VC.view)
            VC.didMove(toParentViewController: self)
            
            currentContentVC = VC
        }
        
        animate(toOrigin: true)
        navigationItem.title = stringify(menuOption: option)
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        let nextC = segue.destination
        if nextC is UINavigationController {
            let composeVC = (nextC as! UINavigationController).topViewController as! TweetComposeViewController
            composeVC.user = User.currentUser
        }
    }

}
