//
//  ViewController.swift
//  SwiftAlertController
//
//  Created by 张行 on 16/8/6.
//  Copyright © 2016年 张行. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        

        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func buttonClick(sender: AnyObject) {

        var alertStyle = SwiftAlertControllerStyle.alertView
        // 设置为actionSheet
        alertStyle = SwiftAlertControllerStyle.actionSheet

        let alert:SwiftAlertController = SwiftAlertController(style: alertStyle, title: nil, message: "alert", otherButtons: ["Other"])
        alert.showAlertController(self, complete: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

