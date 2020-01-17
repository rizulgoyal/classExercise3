//
//  MapViewController.swift
//  classExercise3
//
//  Created by Rizul goyal on 2020-01-14.
//  Copyright © 2020 Rizul goyal. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
     var locations = [CLLocationCoordinate2D]()

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
            mapView.setRegion(region, animated: true)
            
            //adding annotation for the map
            
    //        let annotation = MKPointAnnotation()
    //        annotation.title = "Toronto"
    //        annotation.subtitle = "Lets take the tour"
    //        annotation.coordinate = location
    //        mapView.addAnnotation(annotation)
            
            
            let uiLogr = UITapGestureRecognizer(target: self, action: #selector(longPress))
            
            mapView.addGestureRecognizer(uiLogr)
            

            
            
        }
        
       
        
        @objc func longPress(gestureRecogniser: UIGestureRecognizer)
        {
            let touchPoint = gestureRecogniser.location(in: mapView)
                      let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                      
                      let annotation = MKPointAnnotation()
                      annotation.coordinate = coordinate
            mapView.removeAnnotation(annotation)

            if mapView.annotations.count < 3
            {
            let touchPoint = gestureRecogniser.location(in: mapView)
                let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.subtitle = "Latitude: \(coordinate.latitude) Longitude : \(coordinate.longitude)"
                mapView.addAnnotation(annotation)
                
                
                let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let location2D = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            locations.append(location2D)
                for i in locations
                {
                    print(String(i.latitude) + "\n" + String(i.longitude))
                }
                
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
                            address = address + placemark.subThoroughfare! + "\n"
                        }
                        
                        if placemark.thoroughfare != nil{
                            address = address + placemark.thoroughfare! + "\n"
                        }
                        
                        if placemark.subLocality != nil{
                            address = address + placemark.subLocality!  + "\n"
                        }
                        
                        if placemark.subAdministrativeArea != nil{
                            annotation.title = placemark.subAdministrativeArea

                            address = address + placemark.subAdministrativeArea! + "\n"
                        }
                        
                        if placemark.postalCode != nil{
                            address = address + placemark.postalCode! + "\n"
                        }
                        
                        if placemark.country != nil{
                            address = address + placemark.country! + "\n"
                        }
                      
                      print(address)
                  }
                }
                }

                

                
            
            
            
            
            

            
            
            
            
        }
            if mapView.annotations.count == 3
            {
                addPolygon()

            }
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
            mapView.delegate=self
                let polygon = MKPolygon(coordinates: &locations, count: locations.count)
                mapView.addOverlay(polygon)
            
            // add circle to the annotation
            let overlays = locations.map{(MKCircle(center: $0, radius: 1000))}
            mapView.addOverlays(overlays)
            
            
            
            
            
            // end of circle
                
            
               
               
           }

    }

    extension ViewController: MKMapViewDelegate
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
