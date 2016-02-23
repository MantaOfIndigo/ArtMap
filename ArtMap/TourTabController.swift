//
//  TourTabController.swift
//  ArtMap
//
//  Created by Andrea Mantani on 15/02/16.
//  Copyright © 2016 Andrea Mantani. All rights reserved.
//

import UIKit

class TourTabController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableData : [TourRecord]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableData = [TourRecord]()
        
        
        
        let nib = UINib(nibName: "TourTableCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 93.0
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(animated: Bool) {
       /* if let result = NSUserDefaults.standardUserDefaults().arrayForKey("tour"){
            let dataStrings = result as! [String]
            print("righe data")
            print(dataStrings.count)
            for data in dataStrings{
                print("ricreato -------------")
                print(TourRecord(fromString: data).getArtist())
                print(TourRecord(fromString: data).getDirection())
                print("---------------------------")
                tableData.append(TourRecord(fromString: data))
            }
            
        }*/
        if let result = NSUserDefaults.standardUserDefaults().arrayForKey("tour"){
            let dataStrings = result as! [String]
            tableData.removeAll()
            if dataStrings.count != 0{
                for index in 0...dataStrings.count - 1{
                    tableData.append(TourRecord(fromString: dataStrings[index]))
                }
            }
            
        }
        self.tableView.reloadData()
        self.tableView.numberOfRowsInSection(0)
    }
    @IBAction func exit(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            tableData.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            refreshList()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    func refreshList(){
        var refreshList = [String]()
        for item in tableData{
            refreshList.append(item.toString())
        }
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("tour")
        NSUserDefaults.standardUserDefaults().setObject(refreshList, forKey: "tour")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueOpenExistingTour"{
            if let result = segue.destinationViewController as? TourIndicationController{
                result.setTourSteps(tableData[(tableView.indexPathForSelectedRow?.row)!].getDirections(), reOpeningTour: true)
            }
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("segueOpenExistingTour", sender: self)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : TourTableCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! TourTableCell
        
        cell.lblArtist.text = ""
        cell.lblIndexId.text = ""
        
        let artistsInTour : [String] = tableData[indexPath.row].getArtist()
        for artist in artistsInTour{
            if artist == artistsInTour.last{
                cell.lblArtist.text! += artist
            }else{
                cell.lblArtist.text! += artist + ", "
            }
        }
        
        cell.lblIndexId.text = String(tableData[indexPath.row].getDirections().count)
        
        return cell
    }
    
}