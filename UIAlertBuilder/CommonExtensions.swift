//
//  CommonExtensions.swift
//  Pods
//
//  Created by Meniny on 2017-08-22.
//
//

import Foundation

public extension String {
  public static func describing(objects: [Any], separatedBy: String? = nil) -> String {
    guard !objects.isEmpty else {
      return ""
    }
    return objects.map({ (m) -> String in
      guard let ms = m as? String else {
        return String(describing: m)
      }
      return ms
    }).joined(separator: separatedBy ?? "")
  }
  
//  public static func describing(objects: Any..., separatedBy: String? = nil) -> String {
//    return describing(objects: objects, separatedBy: separatedBy)
//  }
}
