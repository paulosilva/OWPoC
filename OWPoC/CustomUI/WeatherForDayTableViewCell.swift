//
//  WeatherForDayTableViewCell.swift
//  OWPoC
//
//  Created by Paulo Silva on 02/07/2018.
//  Copyright © 2018 Paulo Silva. All rights reserved.
//

import UIKit

class WeatherForDayTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet private weak var hourCollectionView: UICollectionView!
    
}

extension WeatherForDayTableViewCell {
    
    func setHourCollectionViewDataSourceDelegate <D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        hourCollectionView.delegate = dataSourceDelegate
        hourCollectionView.dataSource = dataSourceDelegate
        hourCollectionView.tag = row
        
        // Stops collection view if it was scrolling.
        hourCollectionView.setContentOffset(hourCollectionView.contentOffset, animated: false)
        
        hourCollectionView.reloadData()
    }
    
    var hourCollectionViewOffset: CGFloat {
        set { hourCollectionView.contentOffset.x = newValue }
        get { return hourCollectionView.contentOffset.x }
    }
    
}

