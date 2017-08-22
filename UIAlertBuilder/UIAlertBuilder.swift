//
//  UIAlertBuilder.swift
//  Crucio
//
//  Created by Meniny on 2016-08-18.
//  Copyright © 2016 Sky Platanus. All rights reserved.
//

import Foundation

open class UIAlertBuilder {
  
  open var title: String? = nil
  open var message: String? = nil
  open var actions: [UIAlertActionDescription] = []
  open var textfields: [UIAlertTextFieldDescription] = []
  open var actionClosure: UIAlertActionClosure? = nil
  open var hiddingCompletion: UIAlertHiddingCompletion? = nil
  
  open var barButtonItem: UIBarButtonItem? = nil
  open var popoverSourceView: UIView? = nil
  open var popoverSourceRect: CGRect? = nil
  open var textAlignment: NSTextAlignment = .center
  open var lineBreakMode: NSLineBreakMode = .byWordWrapping
  open var messageFont: UIFont? = nil
  open var textColor: UIColor? = nil
  
  open var alertController: UIAlertController? = nil
  
  @discardableResult
  open func setTitle(_ title: String?) -> UIAlertBuilder {
    self.title = title
    return self
  }
  
  @discardableResult
  open func setTitle(_ object: Any?) -> UIAlertBuilder {
    if let o = object {
      self.title = String(describing: o)
    } else {
      self.title = nil
    }
    return self
  }
  
  @discardableResult
  open func setMessage(_ message: String?) -> UIAlertBuilder {
    self.message = message
    return self
  }
  
//  @discardableResult
//  open func setMessage(_ objects: Any...) -> UIAlertBuilder {
//    self.message = String.describing(objects: objects, separatedBy: "\n")
//    return self
//  }
  
  @discardableResult
  open func setMessage(_ objects: [Any]) -> UIAlertBuilder {
    self.message = String.describing(objects: objects, separatedBy: "\n")
    return self//setMessage(objects)
  }
  
  @discardableResult
  open func addButton(style: UIAlertActionStyle = .default, title: String, image: UIImage? = nil) -> UIAlertBuilder {
    return addImageButtons(style: style, [title: image])
  }
  
  @discardableResult
  open func addButtons(style: UIAlertActionStyle = .default, _ buttons: [String]) -> UIAlertBuilder {
    self.actions.append(contentsOf: buttons.map { (t) -> UIAlertActionDescription in
      return UIAlertActionDescription(title: t, style: style, image: nil, isEnabled: true)
    })
    return self
  }
  
//  @discardableResult
//  open func addButtons(style: UIAlertActionStyle = .default, _ buttons: String...) -> UIAlertBuilder {
//    return addButtons(style: style, buttons)
//  }
  
  @discardableResult
  open func addImageButtons(style: UIAlertActionStyle = .default, _ buttons: [String: UIImage?]) -> UIAlertBuilder {
    for (t, i) in buttons {
      self.actions.append(UIAlertActionDescription.normal(title: t, image: i, isEnabled: true))
    }
    return self
  }
  
  @discardableResult
  open func addButtons(_ buttons: [UIAlertActionDescription]) -> UIAlertBuilder {
    self.actions.append(contentsOf: buttons)
    return self
  }
  
//  @discardableResult
//  open func addButtons(_ buttons: UIAlertActionDescription...) -> UIAlertBuilder {
//    return addButtons(buttons)
//  }
  
//  @discardableResult
//  open func addTextFields(_ fileds: UIAlertTextFieldDescription...) -> UIAlertBuilder {
//    self.textfields.append(contentsOf: fileds)
//    return self
//  }
  
  @discardableResult
  open func addTextFields(_ fileds: [UIAlertTextFieldDescription]) -> UIAlertBuilder {
    self.textfields.append(contentsOf: fileds)
    return self
  }
  
  @discardableResult
  open func addTextFields(_ placeholders: [String]) -> UIAlertBuilder {
    self.textfields.append(contentsOf: placeholders.map { (p) -> UIAlertTextFieldDescription in
      return UIAlertTextFieldDescription.normal(placeholder: p)
    })
    return self
  }
  
  @discardableResult
  open func addTextField(_ placeholder: String?, text: String? = nil, secureEntry: Bool = false) -> UIAlertBuilder {
    return addTextFields([UIAlertTextFieldDescription(text: text, placeholder: placeholder, secureEntry: secureEntry)])
  }
  
//  @discardableResult
//  open func addTextFields(_ placeholders: String...) -> UIAlertBuilder {
//    return addTextFields(placeholders)
//  }
  
  @discardableResult
  open func addPasswordFields(_ placeholders: [String]) -> UIAlertBuilder {
    self.textfields.append(contentsOf: placeholders.map { (p) -> UIAlertTextFieldDescription in
      return UIAlertTextFieldDescription.password(placeholder: p)
    })
    return self
  }
  
//  @discardableResult
//  open func addPasswordFields(_ placeholders: String...) -> UIAlertBuilder {
//    return addPasswordFields(placeholders)
//  }
  
  @discardableResult
  open func setBarButtonItem(_ item: UIBarButtonItem?) -> UIAlertBuilder {
    self.barButtonItem = item
    return self
  }

  @discardableResult
  open func setPopoverSourceView(_ sourceView: UIView?) -> UIAlertBuilder {
    self.popoverSourceView = sourceView
    return self
  }

  @discardableResult
  open func setPopoverSourceRect(_ sourceRect: CGRect?) -> UIAlertBuilder {
    self.popoverSourceRect = sourceRect
    return self
  }

  @discardableResult
  open func setAlignment(_ alignment: NSTextAlignment) -> UIAlertBuilder {
    self.textAlignment = alignment
    return self
  }

  @discardableResult
  open func setLineBreakMode(_ mode: NSLineBreakMode) -> UIAlertBuilder {
    self.lineBreakMode = mode
    return self
  }

  @discardableResult
  open func setFont(_ font: UIFont?) -> UIAlertBuilder {
    self.messageFont = font
    return self
  }

  @discardableResult
  open func setTextColor(_ color: UIColor?) -> UIAlertBuilder {
    self.textColor = color
    return self
  }
  
  @discardableResult
  open func show(_ style: UIAlertControllerStyle,
            from controller: UIViewController,
            completion: UIAlertActionClosure?) -> UIAlertBuilder {
    
    self.actionClosure = completion
    
    let alert = UIAlertController(title: self.title,
                                       message: self.message,
                                       preferredStyle: style)
    
    if let info = message {
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = self.textAlignment
      paragraphStyle.lineBreakMode = self.lineBreakMode
      
      let messageText = NSMutableAttributedString(string: info, attributes: [
        NSParagraphStyleAttributeName: paragraphStyle,
        NSFontAttributeName: self.messageFont ?? UIFont.systemFont(ofSize: 12),
        NSForegroundColorAttributeName: self.textColor ?? UIColor.darkGray
        ])
      alert.setValue(messageText, forKey: "attributedMessage")
    }
    
    // actions
    if !self.actions.isEmpty {
      
      for i in 0..<self.actions.count {
        
        let o = self.actions[i]
          
        let handler: (UIAlertAction) -> Swift.Void = { (a) in
          if let c = self.actionClosure {
            c(self, i, a.title, a.style)
          } else {
            self.hide()
          }
        }
        
        let action = UIAlertAction(title: o.title, style: o.style, handler: handler)
        // image
        if let img = o.image {
          action.setValue(img, forKey: "image")
        }
        alert.addAction(action)
      }
      
    } else {
      // done button
      let dt = NSLocalizedString("known", comment: "")
      let done = UIAlertAction(title: dt, style: .default, handler: { (d) in
        if let c = self.actionClosure {
          c(self, 0, dt, d.style)
        } else {
          self.hide()
        }
      })
      alert.addAction(done)
    }
    
    // fields
    if !self.textfields.isEmpty {
      for tf in self.textfields {
        alert.addTextField(configurationHandler: { (f) in
          f.text = tf.text
          f.placeholder = tf.placeholder
          f.isSecureTextEntry = tf.secureEntry
        })
      }
    }
    
    alert.popoverPresentationController?.barButtonItem = self.barButtonItem
    alert.popoverPresentationController?.sourceRect = self.popoverSourceRect ?? .zero
    alert.popoverPresentationController?.sourceView = self.popoverSourceView
    
    self.alertController = alert
    
    controller.present(alert, animated: true, completion: nil)
    
    return self
  }
  
  @discardableResult
  open func hide(animated: Bool = true, completion: UIAlertHiddingCompletion? = nil) -> UIAlertBuilder {
    self.alertController?.dismiss(animated: animated, completion: { 
      completion?(self)
    })
    return self
  }
  
}

public extension UIAlertBuilder {
  
  /// Show an alert/action sheet with a default action button
  ///
  /// - Parameters:
  ///   - style: alert or action sheet
  ///   - controller: an `UIViewController` object
  ///   - title: title string
  ///   - messages: message objects, will be joined to a single string with elements separated by `\n`
  /// - Returns: the `UIAlertBuilder` object
  @discardableResult
  public class func show(_ style: UIAlertControllerStyle = .alert, from controller: UIViewController, title: Any?, messages: [Any]) -> UIAlertBuilder {
    return UIAlertBuilder()
      .setTitle(title)
      .setMessage(messages)
      .addButtons([UIAlertActionDescription.normal(title: NSLocalizedString("done", comment: ""))])
      .setBarButtonItem(controller.navigationController?.anyBarButtonItem)
      .setPopoverSourceView(controller.view)
      .setPopoverSourceRect(controller.view.bounds)
      .setAlignment(.center)
      .setLineBreakMode(.byCharWrapping)
      .setFont(UIFont.systemFont(ofSize: 12))
      .setTextColor(UIColor.darkGray)
      .show(style, from: controller, completion: { (b, _, _, _) in
        b.hide()
      })
  }

  /// Show an alert/action sheet with a default action button
  ///
  /// - Parameters:
  ///   - style: alert or action sheet
  ///   - controller: an `UIViewController` object
  ///   - title: title string
  ///   - messages: message objects, will be joined to a single string with elements separated by `\n`
  /// - Returns: the `UIAlertBuilder` object
  @discardableResult
  public class func show(_ style: UIAlertControllerStyle = .alert, from controller: UIViewController, title: Any?, messages: Any...) -> UIAlertBuilder {
    return show(style, from: controller, title: title, messages: messages)
  }
}
