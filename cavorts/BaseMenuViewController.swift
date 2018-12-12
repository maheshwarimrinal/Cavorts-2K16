//
//  BaseMenuViewController.swift
//  cavorts
//
//  Created by Mrinal Maheshwari on 27/07/16.
//  Copyright © 2016 gipl. All rights reserved.
//

import UIKit


class BaseMenuViewController: UIViewController {

    var btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        btn.setImage(UIImage(named: "btn_slidemenu"), for: UIControlState())
        btn.addTarget(self, action: #selector(SSASideMenu.presentRightMenuViewController), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
