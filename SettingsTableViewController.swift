//
//  SettingsTableViewController.swift
//  tips
//
//  Created by Ji Oh Yoo on 1/17/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {


    @IBOutlet weak var postTaxSwitch: UISwitch!
    
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    @IBAction func decreaseMinPerc(sender: AnyObject) {
        var val = getMinPerc()
        val -= 1
        if val < 0 {
            val = 0
        }
        setMinPerc(val)
    }

    @IBAction func decreaseDefaultPerc(sender: AnyObject) {
        var val = getDefaultPerc()
        let limit = getMinPerc()
        val -= 1
        if val < limit {
            val = limit
        }
        setDefaultPerc(val)
    }
    
    @IBAction func decreaseMaxPerc(sender: AnyObject) {
        var val = getMaxPerc()
        let limit = getDefaultPerc()
        val -= 1
        if val < limit {
            val = limit
        }
        setMaxPerc(val)
    }

    @IBAction func increaseMinPerc(sender: AnyObject) {
        var val = getMinPerc()
        let limit = getDefaultPerc()
        val += 1
        if val > limit {
            val = limit
        }
        setMinPerc(val)
    }
    
    @IBAction func increaseDefaultPerc(sender: AnyObject) {
        var val = getDefaultPerc()
        let limit = getMaxPerc()
        val += 1
        if val > limit {
            val = limit
        }
        setDefaultPerc(val)
    }
    @IBAction func increaseMaxPerc(sender: AnyObject) {
        var val = getMaxPerc()
        let limit = 100
        val += 1
        if val > limit {
            val = limit
        }
        setMaxPerc(val)
    }
    
    func getMinPerc() -> Int {
        let percLabelString = minLabel.text!
        return Int(percLabelString.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "%")))!
    }
    func getDefaultPerc() -> Int {
        let percLabelString = defaultLabel.text!
        return Int(percLabelString.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "%")))!
    }
    func getMaxPerc() -> Int {
        let percLabelString = maxLabel.text!
        return Int(percLabelString.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "%")))!
    }
    
    func setMinPerc(value: Int) {
        minLabel.text = "\(value)%"
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(value, forKey: "minPerc")
        defaults.synchronize()
    }
    func setDefaultPerc(value: Int) {
        defaultLabel.text = "\(value)%"
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(value, forKey: "defaultPerc")
        defaults.synchronize()
    }
    func setMaxPerc(value: Int) {
        maxLabel.text = "\(value)%"
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(value, forKey: "maxPerc")
        defaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        let defaults = NSUserDefaults.standardUserDefaults()
        setMinPerc(defaults.valueForKey("minPerc") as? Int ?? 15)
        setDefaultPerc(defaults.valueForKey("defaultPerc") as? Int ?? 20)
        setMaxPerc(defaults.valueForKey("maxPerc") as? Int ?? 25)
        postTaxSwitch.on = defaults.valueForKey("posttax") as? Bool ?? true
    }
    
    
    @IBAction func preTaxSwitchValueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(postTaxSwitch.on, forKey: "posttax")
        defaults.synchronize()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onTouchDown(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        default:
            return 0
        }
        
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
