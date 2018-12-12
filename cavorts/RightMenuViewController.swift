//
//  RightMenuViewController.swift
//  SSASideMenuExample
//
//  Created by Sebastian Andersen on 06/03/15.
//  Copyright (c) 2015 Sebastian Andersen. All rights reserved.
//

import Foundation
import UIKit

class RightMenuViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.frame = CGRect(x: 150, y: (self.view.frame.size.height / 2.0) - 150, width: self.view.frame.size.width, height: 300)
        tableView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isOpaque = false
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = nil
        tableView.bounces = false
        return tableView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

var data = ["Games","Register","Notifications","Gallery","Results","History","About"]
// MARK : TableViewDataSource & Delegate Methods

extension RightMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //        let titles = ["Games", "Register", "About"]
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text  = data[(indexPath as IndexPath).row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch (indexPath as IndexPath).row {
        case 0:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: Games())
            sideMenuViewController?.hideMenuViewController()
            break
        case 1:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: Register())
            sideMenuViewController?.hideMenuViewController()
            break
        case 2:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: Notifications())
            sideMenuViewController?.hideMenuViewController()
            break
        case 3:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: Gallery())
            sideMenuViewController?.hideMenuViewController()
            break
        case 4:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: Results())
            sideMenuViewController?.hideMenuViewController()
            break
        case 5:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: Success())
            sideMenuViewController?.hideMenuViewController()
            break
        case 6:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: about())
            sideMenuViewController?.hideMenuViewController()
            break
        default:
            break
        }
        
        
    }
    
}

