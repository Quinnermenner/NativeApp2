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
    var wordArray = [String]()
    var placeholderArray = [String]()
    @IBOutlet weak var inputWordTable: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
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
                wordArray.insert(inputWord.text!, at: 0)
                if let nextPlaceholder = story?.getNextPlaceholder() {
                    placeholderArray.insert(nextPlaceholder.lowercased(), at: 0)
                }
                story?.fillInPlaceholder(word: inputWord.text!)
                inputWord.text = ""
                loadLabels()
                inputWordTable.reloadData()
            }
        }
    }
    @IBAction func inputWordReturned(_ sender: UITextField) {
        confirmWord(self)
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
}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let word = wordArray[indexPath.row]
        let placeholder = placeholderArray[indexPath.row]
        
        let cell = inputWordTable.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = word
        cell.detailTextLabel?.text = placeholder
        
        return cell
    }
}
