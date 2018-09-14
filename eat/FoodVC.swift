//
//  FoodVC.swift
//  eat
//
//  Created by Kammeron Nhieu on 9/13/18.
//  Copyright © 2018 Kammeron Nhieu. All rights reserved.
//

import UIKit
import MapKit

class FoodVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var detailsButtonText: UIButton!
    
    var thisLatitude: String = ""
    var thisLongitude: String = ""
    var restaurantIDs = [String]()
    var thisID: String = ""
    
    var menuDelegate: RandomFoodDelegate?
    var menuUrl: String = ""
    var detailsUrl: String = ""
    
    let key = "0c5accffd4db0798bbc5a96fc70ebf3b"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(thisLongitude)
        print(thisLatitude)
        getRestaurant()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func eatHereButtonPressed(_ sender: UIButton) {
        self.menuDelegate?.getMenuUrl(self, menuUrl: menuUrl)
    }
    
    func getRestaurant() {
        // specify the url that we will be sending the GET request to
        let url = URL(string: "https://developers.zomato.com/api/v2.1/geocode?lat=\(thisLatitude)&lon=\(thisLongitude)")
        // create a URLSession to handle the request tasks
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(key, forHTTPHeaderField: "user-key")
        let session = URLSession.shared
        // create a "data task" to make the request and run completion handler
        let task = session.dataTask(with: request, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
            // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    let restaurants = jsonResult["popularity"] as! NSDictionary
                    let array = restaurants["nearby_res"] as! NSArray
                    self.restaurantIDs = array as! [String]
                    self.getChoice()
                }
            } catch {
                print(error)
            }
        })
        // execute the task and then wait for the response
        // to run the completion handler. This is async!
        task.resume()
    }
    
    func getChoice() {
        let num = Int(arc4random_uniform(UInt32(restaurantIDs.count)))
        self.thisID = restaurantIDs[num]
        print(self.thisID)
        let url = URL(string: "https://developers.zomato.com/api/v2.1/restaurant?res_id=\(self.thisID)")
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(key, forHTTPHeaderField: "user-key")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
            // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                    print(jsonResult["name"]!)
                    self.menuUrl = jsonResult["menu_url"] as! String
                    self.detailsUrl = jsonResult["url"] as! String
                    
                    DispatchQueue.main.async {
                        self.nameLabel.text = jsonResult["name"] as? String
                        let imgUrlString = jsonResult["thumb"] as! String
                        print(imgUrlString)
                        if imgUrlString != "" {
                            let imgUrl = NSURL(string: imgUrlString)
//                            print(imgUrl)
                            let data = try? Data(contentsOf: imgUrl! as URL)
                            self.imageView.image = UIImage(data: data!)
                        }
                        
                    }
                }
            } catch {
                print(error)
            }
        })
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "MenuSegue") {
            let navController = segue.destination as! UINavigationController
            let menuController = navController.topViewController as! MenuViewController
            menuController.stringUrl = menuUrl
        }
        
        if(segue.identifier == "MenuSegue") {
            let navController = segue.destination as! UINavigationController
            let menuController = navController.topViewController as! MenuViewController
            menuController.stringUrl = menuUrl
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
