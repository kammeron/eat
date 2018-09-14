//
//  MainVC.swift
//  myLocation
//
//  Created by Kammeron Nhieu on 9/13/18.
//  Copyright © 2018 Kammeron Nhieu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager: CLLocationManager = CLLocationManager()
    var myLatitude: String = ""
    var myLongitude: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        myLatitude = String(location.coordinate.latitude)
        myLongitude = String(location.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantSegue" {
            print("lat: " + myLatitude)
            print("long: " + myLongitude)
//            let destination = segue.destination as! FoodVC
            
            let navController = segue.destination as! UINavigationController
            let destination = navController.topViewController as! FoodVC
            destination.thisLatitude = myLatitude
            destination.thisLongitude = myLongitude
        }
    }
}

