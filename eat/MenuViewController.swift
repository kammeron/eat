//
//  MenuViewController.swift
//  eat
//
//  Created by Edward Shin on 9/13/18.
//  Copyright © 2018 Kammeron Nhieu. All rights reserved.
//

import UIKit
import WebKit

class MenuViewController: UIViewController {
    @IBOutlet weak var menuWebView: WKWebView!
    var url: URL? = nil
    var stringUrl: String = "https://www.zomato.com/new-york-city/otto-enoteca-pizzeria-greenwich-village/menu#tabtop"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = URL(string: stringUrl)
        let request = URLRequest(url: url!)
        
        menuWebView.load(request)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
