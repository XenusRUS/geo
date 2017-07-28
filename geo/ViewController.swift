//
//  ViewController.swift
//  geo
//
//  Created by admin on 28.02.17.
//  Copyright © 2017 vadim. All rights reserved.

import UIKit
import Alamofire
import MapKit
import CoreLocation
import GoogleMaps

class ViewController: UIViewController {
    
    let apiKey = "AIzaSyCTK7zlwQRti_5IIN_WcZU9sxtaY-DYSXI"

    @IBOutlet weak var mapView: MKMapView!
    
    var lat1: NSMutableArray = []
    var lon1: NSMutableArray = []
    var img1: NSMutableArray = []
    var id1: NSMutableArray = []
    var likes1: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        GMSServices.provideAPIKey("AIzaSyCTK7zlwQRti_5IIN_WcZU9sxtaY-DYSXI")
        
        let camera = GMSCameraPosition.camera(withLatitude: lat1[0] as! CLLocationDegrees, longitude:lon1[0] as! CLLocationDegrees, zoom:6)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera:camera)
        self.view = mapView
        
        var i = 0
        
        while img1.count != i {
            if let url = NSURL(string: img1[i] as! String) {
                if let data = NSData(contentsOf: url as URL) {
                    let image = UIImage(data:data as Data,scale:4.0)
                    let imageView = UIImageView(image: image!)
                    imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
                    
                    let position = CLLocationCoordinate2DMake(lat1[i] as! CLLocationDegrees, lon1[i] as! CLLocationDegrees)
                    let mark = GMSMarker(position: position)
                    mark.title = "\(String(describing: likes1[i])) likes"
                    mark.icon = imageView.image
                    mark.map = mapView;
                    i += 1
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

