//
//  Webview.swift
//  cavorts
//
//  Created by Mrinal Maheshwari on 24/08/16.
//  Copyright © 2016 gipl. All rights reserved.
//

import UIKit

class Gallery: BaseMenuViewController, SSASideMenuDelegate, UIWebViewDelegate {
    
    var webview = UIWebView()
    var rootBarButton = UIButton()
    var boxView:UIView!
    
    var window = UIWindow()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.navigationBar.translucent = false
        
        webview.delegate = self
        
        rootBarButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rootBarButton.setTitle("Games", for: UIControlState())
        rootBarButton.frame = CGRect(x: 0, y: 0, width: 70, height: 25)
        rootBarButton.setTitleColor(UIColorFromHex(0x1D62F0, alpha: 0.8), for: UIControlState())
        rootBarButton.addTarget(self, action: #selector(Gallery.games), for: .touchUpInside)
        let rightBtn = UIBarButtonItem(customView: rootBarButton)
        self.navigationItem.leftBarButtonItem = rightBtn
        
        navigationItem.title = "Gallery"
        if Reachability.isConnectedToNetwork(){
            let instagramHooks = "instagram://user?username=bit.cavorts"
            let instagramUrl = URL(string: instagramHooks)
            if UIApplication.shared.canOpenURL(instagramUrl!)
            {
                UIApplication.shared.openURL(instagramUrl!)
                
            } else {
                //redirect to safari because the user doesn't have Instagram
                UIApplication.shared.openURL(URL(string: "http://instagram.com/bit.cavorts")!)
            }
        }else{
            _ = SweetAlert().showAlert("Error", subTitle: "Internet not working connect and try again later", style: .error)
//            SCLAlertView().showError("ERROR", subTitle: "Internet not working connect and try again")
            let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: Games()), rightMenuViewController: RightMenuViewController())
            sideMenu.backgroundImage = UIImage(named: "Background.jpg")
            sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
            sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
            sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 6.0))
            sideMenu.delegate = self
            window.rootViewController = sideMenu
            self.view.window?.rootViewController = sideMenu
        }
        
        self.view.backgroundColor = UIColor.white
      //  self.view.addSubview(adLabel)
        // Do any additional setup after loading the view.
    }
    @objc func games(){
        let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: Games()), rightMenuViewController: RightMenuViewController())
        sideMenu.backgroundImage = UIImage(named: "Background.jpg")
        sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
        sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
        sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 6.0))
        sideMenu.delegate = self
        window.rootViewController = sideMenu
        self.view.window?.rootViewController = sideMenu
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView_Pages: UIWebView) {
        
        // Removes it:
        boxView.removeFromSuperview()
        
    }
    func webViewDidStartLoad(_ webView_Pages: UIWebView) {
        
        // Box config:
        boxView = UIView(frame: CGRect(x: self.view.frame.width/2-40, y: 110, width: 80, height: 80))
        boxView.backgroundColor = UIColor.black
        boxView.alpha = 0.9
        boxView.layer.cornerRadius = 10
        print(self.view.frame.width/2)
        
        // Spin config:
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityView.frame = CGRect(x: 20, y: 12, width: 40, height: 40)
        activityView.startAnimating()
        
        // Text config:
        let textLabel = UILabel(frame: CGRect(x: 0, y: 50, width: 80, height: 30))
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: textLabel.font.fontName, size: 13)
        textLabel.text = "Loading..."
        
        // Activate:
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        view.addSubview(boxView)
    }
    
}
