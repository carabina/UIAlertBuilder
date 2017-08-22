//
//  ViewController.swift
//  Sample
//
//  Created by Meniny on 2017-08-22.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import UIKit
import UIAlertBuilder

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    self.show(.alert, title: self, messages: touches, self.view)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

