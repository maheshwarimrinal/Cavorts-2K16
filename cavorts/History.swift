//
//  Success.swift
//  cavorts
//
//  Created by Mrinal Maheshwari on 27/08/16.
//  Copyright © 2016 gipl. All rights reserved.
//

import UIKit

class Success: BaseMenuViewController, UITableViewDelegate, UITableViewDataSource {

    var table = UITableView()
    var nameArr = NSMutableArray()
    var imageArr = NSMutableArray()
    var sportArr = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Successful Registrations"
        
        table.delegate = self
        table.dataSource = self
        table.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.backgroundColor = UIColor.white
        nameArr.removeAllObjects()
        imageArr.removeAllObjects()
        sportArr.removeAllObjects()
        self.view.addSubview(table)
        table.reloadData()
       // self.view.addSubview(adLabel)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let (resultData, err) = SD.executeQuery("SELECT * FROM database")
        if err != nil{
            print("Some error Exist in database")
        }else{
            nameArr.removeAllObjects()
            imageArr.removeAllObjects()
            sportArr.removeAllObjects()
            for row in resultData{
                let name = row["name"]?.asString()
                let contact = row["sportname"]?.asString()
                let image = row["imagename"]?.asString()
    
                //nameArr.add
    
                nameArr.add(name!)
                sportArr.add(contact!)
                imageArr.add(image!)
    
            }
        }
        return nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        //            table.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    
        //        cell.textLabel?.textColor = UIColor.greenColor()
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        cell.textLabel?.text = nameArr[(indexPath as IndexPath).row] as? String
        cell.detailTextLabel?.text = sportArr[(indexPath as IndexPath).row] as? String
//        cell.detailTextLabel?.textColor = UIColor()
        cell.imageView?.image = UIImage(named: imageArr[(indexPath as IndexPath).row] as! String)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



