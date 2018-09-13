//
//  FoodVC.swift
//  eat
//
//  Created by Kammeron Nhieu on 9/13/18.
//  Copyright © 2018 Kammeron Nhieu. All rights reserved.
//

import UIKit

class FoodVC: UIViewController {
    
//    weak var delegate:
    var thisLatitude: String = ""
    var thisLongitude: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(thisLongitude)
        print(thisLatitude)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
