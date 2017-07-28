//
//  SearchTagViewController.swift
//  geo
//
//  Created by admin on 22.03.17.
//  Copyright © 2017 vadim. All rights reserved.
//

import UIKit
import Alamofire

class SearchTagViewController: UIViewController {

    @IBOutlet weak var tagTextField: UITextField!
    let accessToken = "1693316812.3a9aa96.50ebedab02d04a4499a0cf45b46d4be8"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var lat: NSMutableArray = []
    var lon: NSMutableArray = []
    var img: NSMutableArray = []
    var id: NSMutableArray = []
    var likes: NSMutableArray = []

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        
        Alamofire.request("https://api.instagram.com/v1/tags/\(tagTextField.text! as String)/media/recent?access_token=\(accessToken)", method: .get, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            
            if let JSON = response.result.value as? [String: Any] {
                
                for data in JSON["data"] as! NSArray {
                    let dataa = data as? [String:Any]
                    
                    let location = dataa?["location"] as! NSDictionary
                    let images = dataa?["images"] as! NSDictionary
                    let thumbnail = images["thumbnail"] as! NSDictionary
                    let likesData = dataa?["likes"] as! NSDictionary
                    
                    self.lat.add(location["latitude"] as Any)
                    self.lon.add(location["longitude"] as Any)
                    self.img.add(thumbnail["url"] as Any)
                    self.id.add(dataa?["id"] as Any)
                    self.likes.add(likesData["count"] as Any)
                }
                
                vc.lat1 = self.lat
                vc.lon1 = self.lon
                vc.img1 = self.img
                vc.id1 = self.id
                vc.likes1 = self.likes
                self.present(vc, animated: true, completion: nil)
                
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
