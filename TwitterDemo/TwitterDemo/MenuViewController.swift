//
//  MenuViewController.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/7/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate : NSObjectProtocol {
    func menuViewController(_menuViewController : MenuViewController, didSelectOption option: MenuOptions)
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuTableView: UITableView!
    
    weak var delegate : MenuViewControllerDelegate?        
    
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
        
        menuTableView.estimatedRowHeight = 200
        menuTableView.rowHeight = UITableViewAutomaticDimension
        
        menuTableView.tableFooterView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize.zero))
        menuTableView.backgroundColor = UIColor(red: 0/255.0, green: 167/255.0, blue: 250/255.0, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.totalCount.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptionCell", for: indexPath) as! MenuOptionCell
        cell.menuOptionName.text = stringify(menuOption: MenuOptions(rawValue: indexPath.row)!)        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.menuViewController(_menuViewController: self, didSelectOption: MenuOptions(rawValue: indexPath.row)!)
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
