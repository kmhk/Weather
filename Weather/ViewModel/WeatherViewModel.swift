//
//  WeatherViewModel.swift
//  Weather
//
//  Created by com on 3/3/1398 AP.
//  Copyright © 1398 KMHK. All rights reserved.
//

import UIKit
import CoreLocation


let APPID = "f0a06c53167f25fec11b2c6db5258636"
let URLIcon = "https://openweathermap.org/img/w/"
let URLWeather1 = "https://api.openweathermap.org/data/2.5/weather?APPID=%@&lat=%d&lon=%d&units=metric"
let URLWeather2 = "https://api.openweathermap.org/data/2.5/group?APPID=%@&id=%@&units=metric"


class WeatherViewModel: NSObject {
    
    // MARK:  - member variables
    let cities = [
        "2643743", // London
        "1850147" // Tokyo
    ]
    
    var weathers: [WeatherItem] = []
    var curLoc: CLLocationCoordinate2D?
    

    // MARK: - member methods
    static func shared() -> WeatherViewModel {
        guard _gWeatherModel == nil else {
            return _gWeatherModel!
        }
        
        _gWeatherModel = WeatherViewModel()
        
        return _gWeatherModel!
    }
    
    
    override init() {
        super.init()
    }
    
    
    func getCityWeather(completion: (()->())?, failed: ((Error)->())?) {
        guard let curLoc = curLoc else {
            return
        }
        
        weathers.removeAll()
        
        // get my location's weather by location
        var url = String(format: URLWeather1,
                         APPID,
                         Int((curLoc.latitude)),
                         Int((curLoc.longitude)))
        var urlReq = URLRequest(url: URL(string: url)!)
        
        sendReq(urlReq: urlReq, completion: completion, failed: failed)
        
        // get other city's weather
        let params = cities.joined(separator: ",")
        url = String(format: URLWeather2, APPID, params)
        urlReq = URLRequest(url: URL(string: url)!)
        
        sendReq(urlReq: urlReq, completion: completion, failed: failed)
    }
    
    
    func sendReq(urlReq: URLRequest, completion: (()->())?, failed: ((Error)->())?) {
        URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            if let error = error {
                print("\(error)")
                if let failed = failed {
                    failed(error)
                }
                return
                
            } else if let data = data {
                do {
                    let doc = try JSONSerialization.jsonObject(with: data,
                                                               options: .mutableContainers)
                    if let array = (doc as! [String: Any])["list"] {
                        for city in (array as! [Any]) {
                            let item = WeatherItem(dict: city as! [String: Any])
                            self.weathers.append(item)
                        }
                    } else {
                        let item = WeatherItem(dict: doc as! [String: Any])
                        self.weathers.append(item)
                    }
                    
                    if let completion = completion {
                        completion()
                    }
                    
                } catch let error {
                    print("\(error)")
                    if let failed = failed {
                        failed(error)
                    }
                }
            }
        }.resume()
    }
}

var _gWeatherModel: WeatherViewModel? = nil
