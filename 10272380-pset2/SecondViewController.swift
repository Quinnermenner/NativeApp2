//
//  SecondViewController.swift
//  10272380-pset2
//
//  Created by Quinten van der Post on 07/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    var story: Story?
    @IBOutlet weak var wordCount: UILabel!
    @IBOutlet weak var wordDesc: UILabel!
    @IBOutlet weak var inputWord: UITextField!
    @IBOutlet weak var secondStoryButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    func printStory(){
        let storyText = story?.toString()
        print(storyText!)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        inputWord.delegate = self

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
            if remainingCount == 0 {
                performSegue(withIdentifier: "segueToThirdVC", sender: self)
            }
            if remainingCount > 0 {
                story?.fillInPlaceholder(word: inputWord.text!)
                inputWord.text = ""
                loadLabels()
                printStory()
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        secondStoryButton.isHidden = false
        secondStoryButton.isEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        secondStoryButton.isHidden = true
        secondStoryButton.isEnabled = false
    }
    
    func loadLabels() {
        if story?.getNextPlaceholder() == "" {
            wordDesc.text = "Done!"
            wordCount.text = ""
            loadSubmitButton()
        }
        else {
            loadWordDesc()
            loadWordCount()
            loadSubmitButton()
        }
    }
    
    func loadWordDesc() {
        if let nextPlaceholder = story?.getNextPlaceholder() {
            wordDesc.text = "please enter a(n) " + nextPlaceholder.lowercased()
        }
    }
    
    func loadWordCount() {
        if let placeHolderCount = story?.getPlaceholderRemainingCount() {
            wordCount.text = String(placeHolderCount) + " word(s) left"
        }
    }
    
    func loadSubmitButton() {
        if let remainingCount = story?.getPlaceholderRemainingCount() {
            if remainingCount > 0 {
                submitButton.setTitle("Submit", for: .normal)
            }
            else {
                submitButton.setTitle("See story", for: .normal)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let passTest = story?.getPlaceholderRemainingCount(){
            if passTest > 0 {
            let alertController = UIAlertController(title: "Uh Oh", message: "Please replace all placeholders.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Got it!", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return false
            }
            else {
                return true
            }
        }
        else {
            return false
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
