//
//  Defines.swift
//  Pods
//
//  Created by Meniny on 2017-08-22.
//
//

import Foundation
import UIKit

public struct UIAlertActionDescription {
  public var title: String? = nil
  public var style: UIAlertActionStyle = .default
  public var image: UIImage? = nil
  public var isEnabled: Bool = true
  
  public init(title: String?, style: UIAlertActionStyle = .default, image: UIImage? = nil, isEnabled: Bool = true) {
    self.title = title
    self.style = style
    self.image = image
    self.isEnabled = isEnabled
  }
  
  public static func normal(title: String?, image: UIImage? = nil, isEnabled: Bool = true) -> UIAlertActionDescription {
    return UIAlertActionDescription.init(title: title, style: .default, image: image, isEnabled: isEnabled)
  }
  
  public static func cancel(title: String?, image: UIImage? = nil, isEnabled: Bool = true) -> UIAlertActionDescription {
    return UIAlertActionDescription.init(title: title, style: .cancel, image: image, isEnabled: isEnabled)
  }
  
  public static func destructive(title: String?, image: UIImage? = nil, isEnabled: Bool = true) -> UIAlertActionDescription {
    return UIAlertActionDescription.init(title: title, style: .destructive, image: image, isEnabled: isEnabled)
  }
}

public struct UIAlertTextFieldDescription {
  public var text: String? = nil
  public var placeholder: String? = nil
  public var secureEntry: Bool = false
  
  public init(text: String? = nil, placeholder: String?, secureEntry: Bool = false) {
    self.text = text
    self.placeholder = placeholder
    self.secureEntry = secureEntry
  }
  
  public static func normal(_ text: String? = nil, placeholder: String?) -> UIAlertTextFieldDescription {
    return UIAlertTextFieldDescription(text: text, placeholder: placeholder, secureEntry: false)
  }
  
  public static func password(_ pwd: String? = nil, placeholder: String?) -> UIAlertTextFieldDescription {
    return UIAlertTextFieldDescription(text: pwd, placeholder: placeholder, secureEntry: true)
  }
}

/// Closure contains index, title and style information of the tapped action
public typealias UIAlertActionClosure = (_ builder: UIAlertBuilder,_ index: Int, _ title: String?, _ style: UIAlertActionStyle?) -> Swift.Void
public typealias UIAlertHiddingCompletion = (_ builder: UIAlertBuilder) -> Swift.Void
