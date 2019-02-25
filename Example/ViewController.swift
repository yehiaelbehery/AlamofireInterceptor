//
//  ViewController.swift
//  Example
//
//  Created by Nehal Elsawaf on 2/17/19.
//  Copyright © 2019 Yehia Elbehery. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireInterceptor
import Floaty

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let floaty = Floaty()
        floaty.addItem(title: "Last Alamofire request") { (item) in
            AlamofireInterceptor.shared.launch()
        }
        self.view.addSubview(floaty)
    }
    @IBAction func launch(){
        
        AlamofireInterceptor.shared.request("https://api.jsonbin.io/b/5c71e345a959266e3a1df09e", parameters: ["param": "value"]).responseJSON(completionHandler: { response in
            print("=>>> ", response)
            
            })
    }
}

