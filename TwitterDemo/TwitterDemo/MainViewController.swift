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

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    
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
        // SIJI TODO: Do proper VC handling for this.
        menuView.addSubview(menuVC.view)
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
