//
//  ViewController.swift
//  10272380-pset2
//
//  Created by Quinten van der Post on 07/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func randomStory() -> Story{
        var res = ""
        if let asset = NSDataAsset(name: "madlib0_simple"), let string = String(data:asset.data, encoding: String.Encoding.utf8){
            res = string
        }
        let story = Story(stream: res)
        return story
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SecondViewController{
        secondVC.story = randomStory()
        }
    }
}

