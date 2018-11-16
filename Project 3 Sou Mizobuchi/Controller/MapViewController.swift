//
//  MapViewController.swift
//  Project 3 Sou Mizobuchi
//
//  Created by user144546 on 11/14/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // Mark - constatnt
    private struct Constant {
        static let AnnotationReuseIdentifier = "MapPin"
    }
    
    // Mark - property
    var locationManager = CLLocationManager()
    
    // Mark - outlet
    @IBOutlet weak var mapView: MKMapView!
    
    
    // Mark - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let splitVC = splitViewController {
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        }
        
        // find current location
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: Constant.AnnotationReuseIdentifier)
        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2DMake(40, -111)
//        annotation.title = "Turner"
//        annotation.subtitle = "subtitle here"
//        mapView.addAnnotation(annotation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2DMake(40, -111), fromEyeCoordinate: CLLocationCoordinate2DMake(40, -111), eyeAltitude: 500)
//        mapView.setCamera(camera, animated: true)
//
//        let center = CLLocationCoordinate2DMake(40, -111)
//        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        let viewRegion = MKCoordinateRegion(center: center, span: span)
//        mapView.setRegion(viewRegion, animated: true)
    }
    
    // Mark - mapview delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: Constant.AnnotationReuseIdentifier, for: annotation)
        if let pinView = view as? MKPinAnnotationView {
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            pinView.pinTintColor = .purple
        }
        
        return view
    }
    
    // Mark - location manager delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // Makr - helper
    func configureMap(_ geoplaces: [GeoPlace]) {
        var maxLatitude = 0.0
        var minLatitude = 0.0
        var maxLongitude = 0.0
        var minLongitude = 0.0
        
        for place in geoplaces {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(place.latitude, place.longitude)
            annotation.title = place.placename
            annotation.subtitle = "subtitle"
            mapView.addAnnotation(annotation)
            
            maxLatitude = maxLatitude < place.latitude ? place.latitude : maxLatitude
            minLatitude = minLatitude > place.latitude ? place.latitude : minLatitude
            maxLongitude = maxLongitude < place.longitude ? place.longitude : maxLongitude
            minLongitude = minLongitude > place.longitude ? place.longitude : minLongitude
        
            let center = CLLocationCoordinate2DMake(place.latitude, place.longitude)
            let span = MKCoordinateSpan(latitudeDelta: (maxLatitude - minLatitude), longitudeDelta: (maxLongitude - minLongitude))
            let viewRegion = MKCoordinateRegion(center: center, span: span)
            mapView.setRegion(viewRegion, animated: true)
        }
    }
}
