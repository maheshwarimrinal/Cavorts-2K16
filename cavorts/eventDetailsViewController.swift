//
//  EventDetailsViewController.swift
//  cavorts
//
//  Created by Mrinal Maheshwari on 15/07/16.
//  Copyright © 2016 gipl. All rights reserved.
//

import UIKit

class eventDetailsViewController: UIViewController {
    
    var scroll = UIScrollView()
    var eventImageView = UIImageView()
    var eventLabel = UILabel()
    var eventDetails = UITextView()
    var regBtn = UIButton()
    
    var height = CGFloat()
    var width = CGFloat()
    
    var data:String!
    
    //    var data  = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.isTranslucent = false
        
        height = self.view.frame.height
        width = self.view.frame.width
        
        scroll.frame = CGRect(x: 0, y: 0, width: width, height: height)
        scroll.backgroundColor = UIColor.white
        self.view.addSubview(scroll)
        
        eventImageView.frame = CGRect(x: width/2-75, y: 10, width: 150, height: 150)
        self.scroll.addSubview(eventImageView)
        
        eventLabel.frame = CGRect(x: 10, y: eventImageView.frame.origin.y + eventImageView.frame.size.height + 5, width: self.view.frame.width - 20, height: 40)
        eventLabel.textAlignment = .center
        self.scroll.addSubview(eventLabel)

        eventDetails.frame = CGRect(x: 10, y: eventLabel.frame.origin.y + eventLabel.frame.size.height + 5, width: self.view.frame.width - 20,height: height - eventImageView.frame.height + eventLabel.frame.height - 160)
        eventDetails.font = UIFont(name: "times new roman", size: 15)
        eventDetails.textAlignment = .left
        eventDetails.isEditable = false
        self.view.addSubview(eventDetails)
        
        regBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        regBtn.setTitle("Register", for: UIControlState())
        regBtn.setTitleColor(UIColor.black, for: UIControlState())
        regBtn.setTitleColor(UIColorFromHex(0x1D62F0, alpha: 0.8), for: UIControlState())
        //        regBtn.layer.cornerRadius = 5
        //        regBtn.layer.borderWidth = 1
        //        regBtn.layer.borderColor = UIColor.init(red: 0, green: 122, blue: 255, alpha: 1).CGColor
        regBtn.addTarget(self, action: #selector(eventDetailsViewController.jump), for: .touchUpInside)
        let rbtn = UIBarButtonItem(customView: regBtn)
        navigationItem.rightBarButtonItem = rbtn
        
        
        scroll.isScrollEnabled = true
        scroll.contentSize = CGSize(width: 300, height: eventDetails.frame.origin.y + eventDetails.frame.size.height + 30)
        scroll.addSubview(eventDetails)
    }
    
    @objc func jump(){
        if eventLabel.text == "LAN Gaming"{
            _ = SweetAlert().showAlert("On spot only", subTitle: "Their are only onspot registration for LAN GAMING. Registration only after depositing fee. For furter details contact Event Coordinatior", style: .warning)
//            SCLAlertView().showInfo("ON SPOT ONLY", subTitle: "Their are only onspot registration for LAN GAMING. Registration only after depositing fee. For furter details contact Event Coordinatior")
        }else{
            let vc = Register()
            vc.imgname = data
            vc.eventImageView.image = self.eventImageView.image
            if eventLabel.text == "100m Race"{
                vc.sportName.text = "Running"
            }
            else{            
                vc.sportName.text = eventLabel.text
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
