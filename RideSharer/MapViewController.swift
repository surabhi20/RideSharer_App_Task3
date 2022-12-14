//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController , CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.pausesLocationUpdatesAutomatically = false
        
        if(locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse){
            mapView.showsUserLocation = true
        }
    
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
        
        case .authorizedAlways:
            mapView.showsUserLocation = true
            break
        
        case .denied:
            let dialogMessage = UIAlertController(title: "Permission Denied", message: "You have denied the location permission. Location permission is required to display user location.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            break
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
            break
        
        case .restricted:
            break
        
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            break
       
        @unknown default:
            mapView.showsUserLocation = true
            break
        }
    }
    
}
