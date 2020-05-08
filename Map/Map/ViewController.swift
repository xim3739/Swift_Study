//
//  ViewController.swift
//  Map
//
//  Created by 심재현 on 07/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var myMapview: MKMapView!
    @IBOutlet weak var labelLocation1: UILabel!
    @IBOutlet weak var labelLocation2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        labelLocation1.text = ""
        labelLocation2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMapview.showsUserLocation = true
        
    }
    
    func goLocation(latitude latitudeValue: CLLocationDegrees, longtitude longtitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D{
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMapview.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    func setAnnotation(latitude latitudeValue: CLLocationDegrees, longtitude longtitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subTitle strSubTitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitudeValue, longtitude: longtitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        myMapview.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        goLocation(latitude: (pLocation?.coordinate.latitude)!, longtitude: (pLocation?.coordinate.longitude)!, delta: 0.01)
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: { (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address: String = country!
            
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.labelLocation1.text = "현재 위치"
            self.labelLocation2.text = address
        })
        locationManager.stopUpdatingLocation()
    }

    @IBAction func segmentHandler(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.labelLocation1.text = ""
            self.labelLocation2.text = ""
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitude: 37.584401, longtitude: 126.886107, delta: 1, title: "회사", subTitle: "첨단산업센터")
            self.labelLocation1.text = "보고 있는 위치"
            self.labelLocation2.text = "첨단 산업 센터"
        } else if sender.selectedSegmentIndex == 2 {
            setAnnotation(latitude: 37.526422, longtitude: 126.847462, delta: 0.1, title: "집", subTitle: "우리집")
            self.labelLocation1.text = "보고 있는 위치"
            self.labelLocation2.text = "우리집"
        }
    }
    
}

