//
//  mapViewController.swift
//  classExercise3
//
//  Created by Rizul goyal on 2020-01-14.
//  Copyright © 2020 Rizul goyal. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController {

    @IBOutlet var mapView1: MKMapView!
    //@IBOutlet var mapView: MKMapView!
    var locationLat : [Double] = []
    var locationLong : [Double] = []
    var locationAddress : [String] = []



        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            // define lat and long
            
            let latitude: CLLocationDegrees = 43.64
            let longitude: CLLocationDegrees = -79.38
            
            // define delta lat and long
            
            let latDelta : CLLocationDegrees = 0.05
            let longDelta : CLLocationDegrees = 0.05
            
            //defione span
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            
            // define location
            
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            // define the region
            
            let region = MKCoordinateRegion(center: location, span: span)
            
            // set the region on the map
            mapView1.setRegion(region, animated: true)
            
            //adding annotation for the map
            
    //        let annotation = MKPointAnnotation()
    //        annotation.title = "Toronto"
    //        annotation.subtitle = "Lets take the tour"
    //        annotation.coordinate = location
    //        mapView.addAnnotation(annotation)
            
            
            let uiLogr = UITapGestureRecognizer(target: self, action: #selector(longPress))
            
            mapView1.addGestureRecognizer(uiLogr)
            
            let defaults = UserDefaults.standard
            let templatitude = defaults.array(forKey: "locationlat") as? [Double] ?? [Double]()
            let templongitude = defaults.array(forKey: "locationlong") as? [Double] ?? [Double]()
            let tempaddress = defaults.stringArray(forKey: "locationaddress") ?? [String]()

            locationLat = templatitude
            locationLong = templongitude
            locationAddress = tempaddress
            
        }
        
       
        
        @objc func longPress(gestureRecogniser: UIGestureRecognizer)
        {
            

           
            let touchPoint = gestureRecogniser.location(in: mapView1)
                let coordinate = mapView1.convert(touchPoint, toCoordinateFrom: mapView1)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.subtitle = "Latitude: \(coordinate.latitude) Longitude : \(coordinate.longitude)"
                mapView1.addAnnotation(annotation)
                
                
                let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let location2D = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
           // locations.append(location2D)
                let templat = coordinate.latitude
                let templong = coordinate.longitude
                locationLat.append(templat)
                locationLong.append(templong)
//                for i in locationLat
//                {
//                    print(i)
//                }
//                for j in locationLong
//                {
//                    print(j)
//                }

                let defaults = UserDefaults.standard
                defaults.set(locationLat, forKey: "locationlat")
                defaults.set(locationLong, forKey: "locationlong")
            defaults.synchronize()
            
//                for i in locations
//                {
//                    print(String(i.latitude) + "\n" + String(i.longitude))
//                }
                
                CLGeocoder().reverseGeocodeLocation(location){(placemarks, error) in
                if let error = error
                {
                    print(error)
                }
                else
                {
                    if let placemark = placemarks?[0]{
                        var address = ""
                        if placemark.subThoroughfare != nil{
                            address = address + placemark.subThoroughfare! + " "
                        }
                        
                        if placemark.thoroughfare != nil{
                            address = address + placemark.thoroughfare! + " "
                        }
                        
                        if placemark.subLocality != nil{
                            address = address + placemark.subLocality!  + " "
                        }
                        
                        if placemark.subAdministrativeArea != nil{
                            annotation.title = placemark.subAdministrativeArea

                            address = address + placemark.subAdministrativeArea! + " "
                        }
                        
                        if placemark.postalCode != nil{
                            address = address + placemark.postalCode! + " "
                        }
                        
                        if placemark.country != nil{
                            address = address + placemark.country! + " "
                        }
                      
                      print(address)
                        self.locationAddress.append(address)
                        print(self.locationAddress.count)
                        defaults.set(self.locationAddress, forKey: "locationaddress")
                        defaults.synchronize()

                        
                  }
                }
                

                

                
            
            
            
            
            

            
            
            
            
        }
//            if mapView1.annotations.count == 3
//            {
//                addPolygon()
//
//            }
    //
    //        if count == 3
    //        {
    //        }
    //        else
    //        {
    //            self.count += 1
    //        }
    //
        


    }
        
        
        func addPolygon()
           {
            
         //  let location = locations.map{$0}
//            mapView1.delegate = self
//                let polygon = MKPolygon(coordinates: &locations, count: locations.count)
//                mapView1.addOverlay(polygon)
//            
//            // add circle to the annotation
//            let overlays = locations.map{(MKCircle(center: $0, radius: 1000))}
//            mapView1.addOverlays(overlays)
//
//
            
            
            
            // end of circle
                
            
               
               
           }

    }

    extension mapViewController: MKMapViewDelegate
    {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 2
        return renderer
    }
        else if overlay is MKPolyline{
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 3
            return renderer
        }
        else if overlay is MKPolygon{
            let renderer = MKPolygonRenderer(overlay: overlay)
            renderer.fillColor = UIColor.orange.withAlphaComponent(0.4)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
        
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
                   mapView.removeAnnotations( annotationsToRemove )
           // mapView.removeAnnotation(view.annotation!)
        }


}
