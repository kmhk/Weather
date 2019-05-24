//
//  WeatherItem.swift
//  Weather
//
//  Created by com on 3/3/1398 AP.
//  Copyright © 1398 KMHK. All rights reserved.
//

import UIKit

class WeatherItem: NSObject {
    
    // MARK: - member variables
    var city: String?
    var temperature: String?
    var wind_speed: String?
    var wind_deg: String?
    var cloud: String?
    var icon: String?
    
    // MARK: - member methods
    init(dict: [String: Any]) {
        super.init()
        
        city = dict["name"] as? String
        
        let main = dict["main"] as! [String: Any]
        temperature = (main["temp"] as! NSNumber).stringValue
        
        let wind = dict["wind"] as! [String: Any]
        wind_speed = (wind["speed"] as! NSNumber).stringValue
        wind_deg = (wind["deg"] as! NSNumber).stringValue
        
        let clouds = dict["clouds"] as! [String: Any]
        cloud = (clouds["all"] as! NSNumber).stringValue
        
        let weather = dict["weather"] as! [Any]
        let item = weather.last as! [String: Any]
        icon = item["icon"] as? String
    }
}
