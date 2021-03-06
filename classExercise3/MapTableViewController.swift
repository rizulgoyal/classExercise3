//
//  MapTableViewController.swift
//  classExercise3
//
//  Created by Rizul goyal on 2020-01-17.
//  Copyright © 2020 Rizul goyal. All rights reserved.
//

import UIKit
import  CoreLocation
import MapKit

class MapTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let defaults = UserDefaults.standard
//        let dictionary = defaults.dictionaryRepresentation()
//        dictionary.keys.forEach { key in
//            defaults.removeObject(forKey: key)
//        }
//
}
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let defaults = UserDefaults.standard
        let templat = defaults.array(forKey: "locationlat") as? [Double] ?? [Double]()
        if templat.count > 0
        {
        return templat.count
        }
        return 0
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaults = UserDefaults.standard
           let templat = defaults.array(forKey: "locationlat") as? [Double] ?? [Double]()
        let templong = defaults.array(forKey: "locationlong") as? [Double] ?? [Double]()
        let tempaddress = defaults.stringArray(forKey: "locationaddress") ?? [String]()


        
        for i in templong
        {
            print("tablevc")
            print(i)
        }
        for j in templat
        {
            print("tablevc")
            print(j)
        }

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstcell", for: indexPath)
        let currlat =  templat[indexPath.row]
        let currlong =  templong[indexPath.row]
        let curraddress = tempaddress[indexPath.row]


        
        cell.textLabel?.text = "Lat: \(currlat) Long: \(currlong)"
        cell.detailTextLabel?.text = curraddress
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let defaults = UserDefaults.standard
           let templat = defaults.array(forKey: "locationlat") as? [Double] ?? [Double]()
        let templong = defaults.array(forKey: "locationlong") as? [Double] ?? [Double]()
        let tempaddress = defaults.stringArray(forKey: "locationaddress") ?? [String]()
        
        
        let currlat =  templat[indexPath.row]
        let currlong =  templong[indexPath.row]
        let curraddress = tempaddress[indexPath.row]
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
               
                     let newVC = sb.instantiateViewController(identifier: "mapVC") as! mapSelectViewController
        
        let coordinate = CLLocationCoordinate2D(latitude: currlat, longitude: currlong)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        newVC.annotation = annotation
        newVC.address = curraddress
        
        
               
                     
                     navigationController?.pushViewController(newVC, animated: true)
           }
        

    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
