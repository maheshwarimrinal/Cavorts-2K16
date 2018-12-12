//
//  about.swift
//  cavorts
//
//  Created by Mrinal Maheshwari on 21/08/16.
//  Copyright © 2016 gipl. All rights reserved.
//

import UIKit
import MessageUI

class about: BaseMenuViewController,SSASideMenuDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate{
    
    var label = UITextView()
    var rootBarButton = UIButton()
    var table = UITableView()
    var detailData = ["Developers","Head Coordinators"]
    var userDetail = [["Mrinal Maheshwari","Devang Chhajed","Saransh Agarwal"],["Parth Bohra","Mrinal Jain","Sandeep Saini","Himanshu Kamra","D K Rajak"]]
    var detailLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "About"
        rootBarButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rootBarButton.setTitle("Games", for: UIControlState())
        rootBarButton.frame = CGRect(x: 0, y: 0, width: 70, height: 25)
        rootBarButton.setTitleColor(UIColorFromHex(0x1D62F0, alpha: 0.8), for: UIControlState())
        rootBarButton.addTarget(self, action: #selector(about.games), for: .touchUpInside)
        let rightBtn = UIBarButtonItem(customView: rootBarButton)
        self.navigationItem.leftBarButtonItem = rightBtn

        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 90)
        table.backgroundColor = UIColor.white
        self.view.addSubview(table)
        
        detailLabel.frame = CGRect(x: 0, y: self.view.frame.height - 90, width: self.view.frame.width, height: 90)
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.numberOfLines = 3
        detailLabel.backgroundColor = UIColor.lightGray
        detailLabel.text = "For any other details feel free to contact us.\nRate and Review the app."
        detailLabel.textAlignment = .center
        self.view.addSubview(detailLabel)
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(label)
        //self.view.addSubview(adLabel)
    }
    
    @objc func games(){
        let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: Games()), rightMenuViewController: RightMenuViewController())
        sideMenu.backgroundImage = UIImage(named: "Background.jpg")
        sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
        sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
        sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 6.0))
        sideMenu.delegate = self
        self.view.window?.rootViewController = sideMenu
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch userDetail[indexPath.section][indexPath.row] {
        case "Mrinal Maheshwari":
            sendEmail("maheshwari.mrinal@gmail.com")
        case "Devang Chhajed":
            sendEmail("devangchhajed@hotmail.com")
        case "Saransh Agarwal" :
            sendEmail("agarwalsaransh95@gmail.com")
        case "Parth Bohra":
            sendCall(09561914988)
        case "Mrinal Jain":
            sendCall(09783906006)
        case "Sandeep Saini" :
            sendCall(09887166707)
        case "Himanshu Kamra" :
            sendCall(07791933229)
        case "D K Rajak" :
            sendCall(08384914312)
        default:
            print("error")
        }
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetail[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = userDetail[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return detailData[section]
    }
    
    func sendCall(_ number: intmax_t){
        
        let alertController = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Call", style: UIAlertActionStyle.default) {
            UIAlertAction in
                if let url = URL(string: "tel://\(number)"){
                    UIApplication.shared.openURL(url)
                }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)

    }
    
    func sendEmail(_ mailid: String) {
        
        let alertController = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
        print("here")
        // Create the actions
        let okAction = UIAlertAction(title: "Send Mail", style: UIAlertActionStyle.default) {
            UIAlertAction in
            if( MFMailComposeViewController.canSendMail() ) {
            print("Can send email.")
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            //Set the subject and message of the email
            mailComposer.setSubject("iOS App feedback")
            mailComposer.setToRecipients([mailid])
//            mailComposer.setMessageBody("This is what they sound like.", isHTML: false)
            
            if let filePath = Bundle.main.path(forResource: "swifts", ofType: "wav") {
                print("File path loaded.")
                
                if let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
                    print("File data loaded.")
                    mailComposer.addAttachmentData(fileData, mimeType: "audio/wav", fileName: "swifts")
                }
            }
            self.present(mailComposer, animated: true, completion: nil)
        }
    }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)

        //Check to see the device can send email.
            }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
