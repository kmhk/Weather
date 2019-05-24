//
//  WeatherViewController.swift
//  Weather
//
//  Created by com on 3/3/1398 AP.
//  Copyright © 1398 KMHK. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {
    
    // MARK: - member variables
    let viewModel = WeatherViewModel.shared()
    var locMng: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var tableViewWeather: UITableView!
    

    // MARK: - life cycling methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locMng.delegate = self
        locMng.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locMng.requestAlwaysAuthorization()
        locMng.startUpdatingLocation()
        
        self.title = "Weather"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadWeather()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        vc.item = viewModel.weathers[(sender as! IndexPath).row]
    }

    func loadWeather() {
        viewModel.getCityWeather(completion: {
            DispatchQueue.main.async {
                self.tableViewWeather.reloadData()
            }
            
        }) { (error) in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - UITableView delegate & datasource

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableCell") as! WeatherTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.initCell(item: viewModel.weathers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueNext", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: -

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard self.viewModel.curLoc == nil else {
            return
        }
        
        let loc = locations.last! as CLLocation
        self.viewModel.curLoc = loc.coordinate
        loadWeather()
    }
}
