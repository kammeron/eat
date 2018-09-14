//
//  DetialsViewController.swift
//  eat
//
//  Created by Edward Shin on 9/14/18.
//  Copyright © 2018 Kammeron Nhieu. All rights reserved.
//

import UIKit
import WebKit

class DetialsViewController: UIViewController {
    @IBOutlet weak var detailsWeb: WKWebView!
    
    var stringUrl: String = ""
    var url: URL? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = URL(string: stringUrl)
        print(stringUrl)
        let request = URLRequest(url: url!)

        detailsWeb.load(request)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
