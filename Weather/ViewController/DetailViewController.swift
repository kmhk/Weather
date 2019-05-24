//
//  DetailViewController.swift
//  Weather
//
//  Created by com on 3/3/1398 AP.
//  Copyright © 1398 KMHK. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    // MARK: - variable
    var item: WeatherItem?

    @IBOutlet weak var tableDetail: UITableView!
    
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = item?.city
        tableDetail.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableView delegate & datasource

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        if cell == nil {
            cell = UITableViewCell(style: .value2, reuseIdentifier: "MyCell")
        }
        
        if indexPath.row == 0 {
            cell?.textLabel?.text = "Temperature:"
            cell?.detailTextLabel?.text = item!.temperature! + " ℃"
        } else if indexPath.row == 1 {
            cell?.textLabel?.text = "Wind Speed:"
            cell?.detailTextLabel?.text = (item?.wind_speed!)! + " m/s"
        } else if indexPath.row == 2 {
            cell?.textLabel?.text = "Cloud:"
            cell?.detailTextLabel?.text = (item?.cloud!)! + " %"
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
