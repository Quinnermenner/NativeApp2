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
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent("stories")
        let contents = try! fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
        let random = Int(arc4random_uniform(UInt32(contents.count)))
        var randomStory = contents[random].lastPathComponent.characters.split{$0 == "."}.map(String.init)
        var res = ""
        if let asset = NSDataAsset(name: randomStory[0]), let string = String(data:asset.data, encoding: String.Encoding.utf8){
            res = string
        }
        let story = Story(stream: res)
        return story
    }

}
