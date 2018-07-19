//
//  WeatherForHourCollectionViewCell.swift
//  OWPoC
//
//  Created by Paulo Silva on 03/07/2018.
//  Copyright © 2018 Paulo Silva. All rights reserved.
//

import UIKit

class WeatherForHourCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var time: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var temperature: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
}
