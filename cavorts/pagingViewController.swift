//
//  ViewController.swift
//  SwiftSlideShow
//
//  Created by Malek T. on 4/13/15.
//  Copyright (c) 2015 Medigarage Studios LTD. All rights reserved.
//

import UIKit

class pagingViewController: UIViewController, UIScrollViewDelegate, SSASideMenuDelegate {
    
    var defaults = UserDefaults.standard
    
    var scrollView = UIScrollView()
    var textLabel = UILabel()
    var pageControl = UIPageControl()
    var window: UIWindow!
    var startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //1
        scrollView.isScrollEnabled = false
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.isTranslucent = false
        
        pageControl.frame = CGRect(x: self.view.frame.width/2 - 35, y: self.view.frame.height - 90, width: 70, height: 20)
        
        
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        let scrollViewWidth:CGFloat = scrollView.frame.width
        let scrollViewHeight:CGFloat = scrollView.frame.height
        //2
        textLabel.textAlignment = .center
        textLabel.text = "Hello Bitians!\nPresenting your companion for Cavorts 2K16!"
        textLabel.numberOfLines = 5
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.textColor = UIColor.black
        textLabel.textAlignment = .center
        //        textLabel.backgroundColor = UIColor.brownColor()
        
        startButton.layer.cornerRadius = 4.0
        //        startButton.backgroundColor = UIColorFromHex(0x1D62F0, alpha: 0.8)
        startButton.setTitle("Lets Go", for: UIControlState())
        startButton.addTarget(self, action: #selector(pagingViewController.tap), for: .touchUpInside)
        startButton.setTitleColor(UIColorFromHex(0x1D62F0, alpha: 0.8), for: UIControlState())
        //3
        let imgOne = UIImageView(frame: CGRect(x: 0, y: 0,width: scrollViewWidth, height: scrollViewHeight/2))
        imgOne.image = UIImage(named: "Welcome2")
        let imgTwo = UIImageView(frame: CGRect(x: scrollViewWidth, y: 0,width: scrollViewWidth, height: scrollViewHeight/2 - 30))
        imgTwo.image = UIImage(named: "feature1")
        let imgThree = UIImageView(frame: CGRect(x: scrollViewWidth*2, y: 0,width: scrollViewWidth, height: scrollViewHeight/2))
        imgThree.image = UIImage(named: "news")
        let imgFour = UIImageView(frame: CGRect(x: scrollViewWidth*3, y: 0,width: scrollViewWidth, height: scrollViewHeight/2))
        imgFour.image = UIImage(named: "review")
        
        //        print(imgTwo.frame)
        
        //        imgOne.backgroundColor = UIColor.blueColor()
        //        imgTwo.backgroundColor = UIColor.brownColor()
        //        imgThree.backgroundColor = UIColor.purpleColor()
        //        imgFour.backgroundColor = UIColor.grayColor()
        
        textLabel.frame = CGRect(x: 10, y: imgOne.frame.origin.y + imgOne.frame.height + 10, width: self.view.frame.width - 20, height: 90)
        startButton.frame = CGRect(x: self.view.frame.width/2 - 40, y: pageControl.frame.origin.y + pageControl.frame.height, width: 80, height: 40)
        
        scrollView.addSubview(imgOne)
        scrollView.addSubview(imgTwo)
        scrollView.addSubview(imgThree)
        scrollView.addSubview(imgFour)
        //        scrollView.addSubview(startButton)
        //4
        scrollView.contentSize = CGSize(width: self.scrollView.frame.width * 4, height: self.scrollView.frame.height)
        scrollView.delegate = self
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = UIColor.green
        
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
        self.view.addSubview(textLabel)
        //        self.view.addSubview(startButton)
        self.view.backgroundColor = UIColor.white
        // Schedule a timer to auto slide to next page
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(pagingViewController.moveToNextPage), userInfo: nil, repeats: true)
        
    }
    
    @objc func moveToNextPage (){
        
        // Move to next page
        let pageWidth:CGFloat = scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
            //             Each time you move back to the first slide, you may want to hide the button, uncomment the animation below to do so
//            UIView.animateWithDuration(0.5, animations: { () -> Void in
//                self.startButton.alpha = 0.0
//            })
        }
        self.scrollView.scrollRectToVisible(CGRect(x: slideToX, y: 0, width: pageWidth, height: self.scrollView.frame.height - 20), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tap(){
//        print("tap")
        window = UIWindow(frame: UIScreen.main.bounds)
        let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: Games()), rightMenuViewController: RightMenuViewController())
        sideMenu.backgroundImage = UIImage(named: "Background.jpg")
        sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
        sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
        sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 6.0))
        sideMenu.delegate = self
        window?.rootViewController = sideMenu
        window?.makeKeyAndVisible()
        sideMenuViewController?.contentViewController = UINavigationController(rootViewController: sideMenu)
        
        defaults.set("set", forKey: "view")
        
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView){
        
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        if Int(currentPage) == 0{
            textLabel.text = "Hello Bitians!\nPresenting your companion for Cavorts 2K16!"
        }else if Int(currentPage) == 1{
            textLabel.text = "New features like gallery, results, etc. binded in the app!"
        }else if Int(currentPage) == 2{
            textLabel.text = "Stay updated about cavorts with all the latest news!"
        }else{
            textLabel.text = "We tried our best, Hope you Like it, Share with your friends and review us on App Store"
            //             Show the "Let's Start" button in the last slide (with a fade in animation)
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                self.view.addSubview(self.startButton)
                self.startButton.alpha = 1.0
            })
        }
    }
    
    func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}

