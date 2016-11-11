//
//  PickerViewController.swift
//  10272380-pset2
//
//  Created by Quinten van der Post on 11/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet weak var storyPicker: UIPickerView!
    var pickerList = [String]()

    @IBAction func buttonSegue(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToSecondVC", sender: self)
    }
    var pickedRow = "Random"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerList.append(pickedRow)
        let pickerBundle = Bundle.main.paths(forResourcesOfType: "txt", inDirectory: "stories.bundle")
        for item in pickerBundle {
            pickerList.append(item)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SecondViewController{
            if pickedRow == "Random" {
                secondVC.story = randomStory()
            }
            else {
                let storyText = try? String(contentsOfFile: pickedRow, encoding: String.Encoding.utf8)
                secondVC.story = Story(stream: storyText!)
            }
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

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (pickerList[row] as NSString).lastPathComponent
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedRow = pickerList[row]
    }

}
