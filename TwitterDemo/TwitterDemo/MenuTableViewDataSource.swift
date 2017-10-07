//
//  MenuTableViewDataSource.swift
//  TwitterDemo
//
//  Created by Siji Rachel Tom on 10/5/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

enum MenuOptions : Int {
    case profile = 0
    case timeLine
    case mentions
    case account
    case totalCount
}

class MenuTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.totalCount.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptionCell", for: indexPath)
        return cell
    }

}
