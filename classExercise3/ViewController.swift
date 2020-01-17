//
//  ViewController.swift
//  classExercise3
//
//  Created by Rizul goyal on 2020-01-14.
//  Copyright © 2020 Rizul goyal. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    @IBOutlet var tableAnnotations: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableAnnotations.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        tableAnnotations.reloadData()
        super.viewWillDisappear(true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaults = UserDefaults.standard
        let templat = defaults.array(forKey: "locationlat") as? [Double]

        return templat!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaults = UserDefaults.standard
           let templat = defaults.array(forKey: "locationlat") as? [Double] ?? [Double]()
        let templong = defaults.array(forKey: "locationlong") as? [Double] ?? [Double]()

        
        for i in templong
        {
            print(i)
        }
        for j in templat
        {
            print(j)
        }

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstcell", for: indexPath)
        let currlat =  templat[indexPath.row]
        let currlong =  templong[indexPath.row]

        
        cell.textLabel?.text = String(currlat + currlong)
        return cell
    }
}

