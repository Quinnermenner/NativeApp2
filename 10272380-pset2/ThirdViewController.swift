//
//  ThridViewController.swift
//  10272380-pset2
//
//  Created by Quinten van der Post on 08/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var story: Story?
    @IBOutlet weak var madLib: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 

        // Do any additional setup after loading the view.
        if let storyText = story?.toString() {
            madLib.text = storyText
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SecondViewController {
            secondVC.story = randomStory()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
