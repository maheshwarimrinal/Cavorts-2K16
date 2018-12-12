//
//  ViewController.swift
//  cavorts
//
//  Created by Mrinal Maheshwari on 04/07/16.
//  Copyright © 2016 gipl. All rights reserved.
//

import UIKit

class Games: BaseMenuViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, XMLParserDelegate {
    
    var strXMLData:String = ""
    var currentElement:String = ""
    var passData:Bool=false
    var passName:Bool=false
    var parser = XMLParser()
    
    var collection : UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
    var imageName = NSMutableArray()
    var textName = NSMutableArray()
    var fileName = NSMutableArray()
    
    var width = CGFloat()
    var heigt = CGFloat()
    
    //    var xmlPath = NSBundle()
    var request = NSMutableURLRequest()
    var data = XMLParser()
    
    var vc = eventDetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
        
        imageName = ["race","Badminton","Basketball","Carrom","Chess","Cricket","GullyCricket","HandBall","HighJump","Kabaddi","KhoKho","LANGaming","LongJump","RopeClimbing","ShotPut","StreetSoccer","TableTennis","TugOfWar","VolleyBall"]
        textName = ["100m Race","Badminton","Basketball","Carrom","Chess","Cricket","Gully Cricket","HandBall","High Jump","Kabaddi","Kho Kho","LAN Gaming","Long Jump","Rope Climbing","Shot Put","Street Soccer","Table Tennis","Tug Of War","Volley Ball"]
        fileName = ["race","Badminton","Basketball","Carrom","Chess","Cricket","GullyCricket","HandBall","HighJump","Kabaddi","KhoKho","LANGaming","LongJump","Rock","ShotPut","StreetSoccer","TableTennis","TugOfWar","Volleyball"]
        
        //        LAYOUT FOR COLLECTION VIEW
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 35, 5)
        layout.itemSize = CGSize(width: self.view.frame.width*0.29, height: self.view.frame.width*0.29)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 0
        //        CREATING COLLECTION VIEW
        collection = UICollectionView(frame: CGRect(x: 0, y: 2, width: self.view.frame.width, height: self.view.frame.height - 70), collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(Collect.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = UIColor.white
        
        self.navigationItem.title = "Games"
        self.view.addSubview(collection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Collect
        cell.image.image = UIImage(named: imageName[indexPath.row] as! String)
        cell.label.text = textName[indexPath.row] as? String
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        vc.eventLabel.text = textName[indexPath.row] as? String
        vc.eventImageView.image = UIImage(named: imageName[indexPath.row] as! String)
        vc.navigationItem.title = textName[indexPath.row] as? String
        self.navigationController?.pushViewController(vc, animated: true)
        
        if let filePath = Bundle.main.path(forResource: fileName[indexPath.row] as? String, ofType: "txt"){
            do{
                let contents = try NSString(contentsOfFile: filePath, usedEncoding: nil) as String
                vc.eventDetails.text = contents
                vc.data = imageName[indexPath.row] as! String
            }catch{
            }
        }
    }
}
