//
//  MapViewController.swift
//  Project 3 Sou Mizobuchi
//
//  Created by user144546 on 11/14/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate {
    
    // Mark - constatnt
    private struct Constant {
        static let AnnotationReuseIdentifier = "MapPin"
        
    }
    
    // Mark - outlet
    @IBOutlet weak var mapView: MKMapView!
    
    
    // Mark - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let splitVC = splitViewController {
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        }
        
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: Constant.AnnotationReuseIdentifier)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(40, -111)
        annotation.title = "Turner"
        annotation.subtitle = "subtitle here"
        mapView.addAnnotation(annotation)
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
}
