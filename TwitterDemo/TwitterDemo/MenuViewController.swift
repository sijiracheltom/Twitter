//
//  MenuViewController.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/7/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuTableView: UITableView!
    
    enum MenuOptions : Int {
        case profile = 0
        case timeLine
        case mentions
        case totalCount
    }
    
    func stringify(menuOption : MenuOptions) -> String! {
        var str = ""
        
        switch menuOption {
        case .profile:
            str = "Profile"
        case .timeLine:
            str = "Timeline"
        case .mentions:
            str = "Mentions"
        case .totalCount:
            str = ""
        }
        
        return str
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.totalCount.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptionCell", for: indexPath) as! MenuOptionCell
        cell.menuOptionName.text = stringify(menuOption: MenuViewController.MenuOptions(rawValue: indexPath.row)!)
        
        return cell
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
