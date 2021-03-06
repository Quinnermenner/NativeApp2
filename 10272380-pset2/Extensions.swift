//
//  UIViewBordersExtension.swift
//  10272380-pset1
//
//  Created by Quinten van der Post on 04/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit

extension UIView
{
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func randomStory() -> Story {
        let storyBundle = Bundle.main.paths(forResourcesOfType: "txt", inDirectory: "stories.bundle")
        let random = Int(arc4random_uniform(UInt32(storyBundle.count)))
        let storyText = try? String(contentsOfFile: storyBundle[random], encoding: String.Encoding.utf8)
        var res = ""
        if let string = storyText {
            res = string
        }
        let story = Story(stream: res)
        return story
    }

}
