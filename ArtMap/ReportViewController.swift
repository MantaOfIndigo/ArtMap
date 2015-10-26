//
//  ReportViewController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 26/10/15.
//  Copyright © 2015 Andrea Mantani. All rights reserved.
//

import UIKit


class ReportViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var setVisibility: UIPickerView!
    
    var pickerValues: [String] = [String]()
    
    @IBAction func back(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func sendReport(sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVisibility.dataSource = self
        setVisibility.delegate = self
        pickerValues = ["Visibile","Rovinato o Inaccessibile","Rimosso o Distrutto"]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
    }
}
