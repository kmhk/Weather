//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by com on 3/3/1398 AP.
//  Copyright © 1398 KMHK. All rights reserved.
//

import UIKit
import SDWebImage

class WeatherTableViewCell: UITableViewCell {
    
    // MARK: - member variables
    @IBOutlet weak var imgViewIcon: UIImageView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    
    
    // MARK: - member methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(item: WeatherItem) {
        let url = URL(string: URLIcon + item.icon! + ".png")
        imgViewIcon.sd_setImage(with: url, placeholderImage: UIImage(named: "ImageLoad"))
        
        lblLocation.text = item.city
        lblTemperature.text = item.temperature! + " ℃"
    }

}
