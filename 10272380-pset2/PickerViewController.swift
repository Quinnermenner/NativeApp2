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
    var pickedRow = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerList.append("Random")
        let pickerBundle = Bundle.main.paths(forResourcesOfType: "txt", inDirectory: "stories.bundle")
        for item in pickerBundle {
            let stringTitle = (item as NSString).lastPathComponent
//            let title = URL(string: item)
//            let stringTitle = title?.lastPathComponent
            pickerList.append(stringTitle)
        }
        print(pickerList)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SecondViewController{
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

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedRow = pickerList[row]
    }

}
