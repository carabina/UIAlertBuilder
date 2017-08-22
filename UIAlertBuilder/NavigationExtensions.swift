//
//  Extensions.swift
//  Pods
//
//  Created by Meniny on 2017-08-22.
//
//

import Foundation
import UIKit

public extension UINavigationController {
  public var anyBarButtonItem: UIBarButtonItem? {
    return navigationItem.rightBarButtonItem ?? navigationItem.leftBarButtonItem ?? navigationItem.backBarButtonItem ?? navigationItem.rightBarButtonItems?.first ?? navigationItem.leftBarButtonItems?.first
  }
}

