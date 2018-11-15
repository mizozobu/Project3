//
//  MapViewController.swift
//  Project 3 Sou Mizobuchi
//
//  Created by user144546 on 11/14/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit

class MapViewController : UIViewController {
    
    // Mark - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let splitVC = splitViewController {
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        }
    }
}
