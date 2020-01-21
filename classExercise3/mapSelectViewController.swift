//
//  mapSelectViewController.swift
//  classExercise3
//
//  Created by Rizul goyal on 2020-01-21.
//  Copyright © 2020 Rizul goyal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapSelectViewController: UIViewController {
    
    @IBOutlet var mapView1: MKMapView!
    var address : String?
    var annotation : MKPointAnnotation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        annotation!.title = "My Location"
        annotation!.subtitle = address
        
                   mapView1.addAnnotation(annotation!)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
