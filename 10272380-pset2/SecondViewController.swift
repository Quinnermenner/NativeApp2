//
//  SecondViewController.swift
//  10272380-pset2
//
//  Created by Quinten van der Post on 07/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var story: Story?
    @IBOutlet weak var wordCount: UILabel!
    @IBOutlet weak var wordDesc: UILabel!
    @IBOutlet weak var inputWord: UITextField!
    
    func printStory(){
        let storyText = story?.toString()
        print(storyText!)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 

        // Do any additional setup after loading the view.
        printStory()
        loadLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmWord(_ sender: Any) {
        if let remainingCount = story?.getPlaceholderRemainingCount() {
            if remainingCount > 0 {
                story?.fillInPlaceholder(word: inputWord.text!)
                inputWord.text = ""
                loadLabels()
                printStory()
            }
        }
    }
    
    func loadLabels() {
        if story?.getNextPlaceholder() == "" {
            wordDesc.text = "Done!"
            wordCount.text = ""
        }
        else {
            loadWordDesc()
            loadWordCount()
        }
    }
    
    
    func loadWordDesc() {
        if let nextPlaceholder = story?.getNextPlaceholder() {
            wordDesc.text = "please enter a(n) " + nextPlaceholder
        }
    }
    
    func loadWordCount() {
        if let placeHolderCount = story?.getPlaceholderRemainingCount() {
            wordCount.text = String(placeHolderCount) + " word(s) left"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let thirdVC = segue.destination as? ThirdViewController {
            thirdVC.story = story
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
