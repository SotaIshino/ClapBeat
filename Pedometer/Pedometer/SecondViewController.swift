//
//  SecondViewController.swift
//  Pedometer
//
//  Created by Owner on 2020/06/09.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class SecondViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var latitubeLabel: UILabel!
    @IBOutlet weak var longitubeLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initMapView()
        self.initLocation()
    }
    
    func initMapView() {
          mapView.isMyLocationEnabled = true
          mapView.delegate = self
      }
    
    func initLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        longitubeLabel.text = String(format: "%f", newLocation.coordinate.longitude)
        latitubeLabel.text = String(format: "%f", newLocation.coordinate.latitude)
        
        let accuracy = newLocation.horizontalAccuracy
        
        if accuracy < 15 {
            accuracyLabel.text = String(format: "高 (%.0f m)", accuracy)
        } else {
            accuracyLabel.text = String(format: "低 (%.0f m)", accuracy)
        }
        
        let pos : GMSCameraPosition = GMSCameraPosition.camera(withLatitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude, zoom: 16.0)
        mapView.camera = pos
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let message = "位置情報の取得に失敗しました。"
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) -> Void in
            print("後で")
        }
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

}
