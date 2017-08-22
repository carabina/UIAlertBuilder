//
//  ViewControllerExtensions.swift
//  Pods
//
//  Created by Meniny on 2017-08-22.
//
//

import Foundation
import UIKit

public extension UIViewController {
  
  /// Show an alert/action sheet with a default action button
  ///
  /// - Parameters:
  ///   - style: alert or action sheet
  ///   - title: title string
  ///   - messages: message objects, will be joined to a single string with elements separated by `\n`
  /// - Returns: the `UIAlertBuilder` object
  @discardableResult
  public func show(_ style: UIAlertControllerStyle, title: Any? = nil, messages: [Any]) -> UIAlertBuilder {
    return UIAlertBuilder.show(style, from: self, title: title, messages: messages)
  }
  
  /// Show an alert/action sheet with a default action button
  ///
  /// - Parameters:
  ///   - style: alert or action sheet
  ///   - title: title string
  ///   - messages: message objects, will be joined to a single string with elements separated by `\n`
  /// - Returns: the `UIAlertBuilder` object
  @discardableResult
  public func show(_ style: UIAlertControllerStyle, title: Any? = nil, messages: Any...) -> UIAlertBuilder {
    return UIAlertBuilder.show(style, from: self, title: title, messages: messages)
  }
  
  @discardableResult
  public func showDebug(_ style: UIAlertControllerStyle, messages: Any..., file: String = #file, method: String = #function, line: Int = #line, action: UIAlertActionClosure?) -> UIAlertBuilder? {
    
    #if DEBUG
      let buttons = [
        UIAlertActionDescription.normal(title: NSLocalizedString("copy", comment: "")),
        UIAlertActionDescription.normal(title: NSLocalizedString("done", comment: "")),
        UIAlertActionDescription.destructive(title: NSLocalizedString("exit", comment: ""))
      ]
      
      var base: [String] = [
        "• DATE: \(Date())",
        "• FILE: \((file as NSString).lastPathComponent)",
        "• PATH: \(file)",
        "• FUNC: \(method)",
        "• LINE: \(line)",
        "• MSGS:\n",
        ]
      base.append(contentsOf: messages.map({ (m) -> String in
        guard let ms = m as? String else {
          return String(describing: m)
        }
        return ms
      }))
      
      let info = base.joined(separator: "\n")
      
      let closure: UIAlertActionClosure = { (ac, idx, opt, sty) in
        
        ac.hide(animated: true)
        action?(ac, idx, opt, sty)
        
        switch idx {
        case 0:
          UIPasteboard.general.string = info
          break
        case 2:
          exit(0)
          break
        default: break
        }
      }
      
      return UIAlertBuilder()
        .setTitle("DEBUG")
        .setMessage(info)
        .addButtons(buttons)
        .setBarButtonItem(navigationController?.anyBarButtonItem)
        .setPopoverSourceView(view)
        .setPopoverSourceRect(view.bounds)
        .setAlignment(.left)
        .setLineBreakMode(.byCharWrapping)
        .setFont(UIFont.systemFont(ofSize: 12))
        .setTextColor(UIColor.darkGray)
        .show(style, from: self, completion: closure)
      
    #else
      return nil
    #endif
  }
  
//  @discardableResult
//  public func showDebug(_ style: UIAlertControllerStyle, messages: T..., file: String = #file, method: String = #function, line: Int = #line, action: UIAlertActionClosure?) -> UIAlertBuilder? {
//    return showDebug(style, messages: messages, file: file, method: method, line: line, action: action)
//  }
}
