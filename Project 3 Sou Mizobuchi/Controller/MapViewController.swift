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
        static let mapEdgePadding = CGFloat(100)
    }
    
    // Mark - property
    var locationManager = CLLocationManager()
    var geoplaces = [GeoPlace]()
    var book = ""
    var chapter = 0
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let splitVC = splitViewController {         
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        }
        setTitle()
        configureMap(geoplaces)
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

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let pin = view.annotation {
            if !(pin is MKUserLocation) {
                let geoplace = GeoDatabase.sharedGeoDatabase.geoPlaceForId(Int((pin.subtitle!)!)!)
                let eyeCoordinate = CLLocationCoordinate2D(latitude: (geoplace?.latitude)!, longitude: (geoplace?.longitude)!)
                let mapCamera = MKMapCamera(lookingAtCenter: eyeCoordinate, fromEyeCoordinate: eyeCoordinate, eyeAltitude: (geoplace?.viewAltitude)!)
                
                mapView.setCamera(mapCamera, animated: true)
                
                title = pin.title!
            }
        }
    }
    
    // Makr - helper
    func setTitle() {
        if book != "" && chapter != 0 {
            title = "\(book) Chapter \(chapter)"
        }
    }
    
    func configureMap(_ geoplaces: [GeoPlace]) {
        mapView.removeAnnotations(mapView.annotations)
        
        var zoomRect = MKMapRect.null;
        for place in geoplaces {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(place.latitude, place.longitude)
            annotation.title = place.placename
            annotation.subtitle = "\(place.id)"
            mapView.addAnnotation(annotation)
            
            let annotationPoint = MKMapPoint(annotation.coordinate);
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0, height: 0);
            if (zoomRect.isNull) {
                zoomRect = pointRect;
            } else {
                zoomRect = zoomRect.union(pointRect);
            }
            mapView.setVisibleMapRect(
                zoomRect,
                edgePadding: UIEdgeInsets(top: Constant.mapEdgePadding, left: Constant.mapEdgePadding, bottom: Constant.mapEdgePadding, right: Constant.mapEdgePadding),
                animated: true
            );
        }
    }
}
