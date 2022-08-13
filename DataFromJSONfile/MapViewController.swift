//
//  ViewController.swift
//  DataFromJSONfile
//
//  Created by Vasili Staratsitarau on 08/08/2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    // MARK: - segue data from cell
    
    var coord1: Coord!
    var name: String!
    var country: String!

    @IBOutlet weak var mapField: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLocationWithPin(location: CLLocationCoordinate2D(latitude: coord1.lat, longitude: coord1.lon))
    }
    // MARK: - function for showing coordinates on map with pin
    
    func showLocationWithPin(location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = name
        annotation.subtitle = "Country: " + country
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapField.setRegion(coordinateRegion, animated: true)
        mapField.addAnnotation(annotation)
    }
}

