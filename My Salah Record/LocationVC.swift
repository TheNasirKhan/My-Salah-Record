//
//  LocationVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 26/10/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class LocationVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnoSetLocation: UIButton!
    
    var center : CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        
        
    }
    
    @IBAction func btnSetLocation(_ sender: Any) {
        
        if let location = center {
            Profile.sharedInstance.location = GeoPoint(latitude: location.latitude, longitude: location.longitude)
            FirebaseFetcher.sharedInstance.addUser(userProfile: Profile.sharedInstance) {
                DispatchQueue.main.async {
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarVC") else { return }
                    self.present(vc, animated: true, completion: nil)
                }
            }
        } else {
            self.popUp(message: "Please select your location")
        }
        
        
        
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        center = mapView.centerCoordinate
        print(center ?? "")
    }

}
