//
//  CollectionViewCell.swift
//  cavorts
//
//  Created by Mrinal Maheshwari on 14/07/16.
//  Copyright © 2016 gipl. All rights reserved.
//

import UIKit

class Collect: UICollectionViewCell {
    var label = UILabel()
    var image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        
        label.frame = CGRect(x: 0, y: frame.width, width: frame.width, height: 28)
        label.font = UIFont(name: "Arial", size: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        self.addSubview(image)
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
