//
//  MapScreen.swift
//  User-Location
//
//  Created by KartRocket iOSOne on 13/09/19.
//  Copyright © 2019 CodesRoom. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapScreen: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
 //   let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorisation()
        }else{
            // show alert letting the user know they have to turn this on
        }
    }
    
    func centerViewOnUserLocatio(){
        if let location = locationManager.location?.coordinate{
    //        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000 , longitudinalMeters: 10000)
     //       mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorisation(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocatio()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // show alert instructing them how to turnoff permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show an alert leting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
}



    extension MapScreen: CLLocationManagerDelegate{
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
            guard let location = locations.last else {return}
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
     //       let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
   //         mapView.setRegion(region, animated: true)
    }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus, locations: [CLLocation]){
            checkLocationAuthorisation()
}

}
