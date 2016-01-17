//
//  ViewController.swift
//  tips
//
//  Created by Ji Oh Yoo on 1/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var taxMode: UISegmentedControl!
    @IBOutlet weak var percLabel: UILabel!
    
    var defaultTint: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        billField.text = "0.00"
        tipLabel.text = "$0.00"
        percLabel.text = "20.0%"
        totalLabel.text = "$0.00"
        defaultTint = tipControl.tintColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        let velocity: CGPoint = sender.velocityInView(view)
        print(velocity, velocity.x)
        if CGFloat.abs(velocity.x) > 10 {
            let percLabelString = percLabel.text!
            var tipPerc = Double(percLabelString.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "%")))!
            if velocity.x > 0 {
                tipPerc += 0.1
            } else {
                tipPerc -= 0.1
            }
            
            if tipPerc > 100.0 {
                tipPerc = 100.0
            } else if tipPerc < 0.0 {
                tipPerc = 0.0
            }
            
            percLabel.text = String(tipPerc) + "%"
            updateFields()
        }
        tipControl.tintColor = UIColor.grayColor()
    }
    
    @IBAction func onEditingChanged(sender: UITextField) {
        let text = billField.text?.stringByReplacingOccurrencesOfString(".", withString: "") ?? ""
        let amount = Double.init(text) ?? 0.0

        billField.text = String(format: "%.2f", amount / 100.0)
        updateFields()
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        var tipPercentages = ["15.0%", "20.0%", "25.0%"]
        percLabel.text = tipPercentages[tipControl.selectedSegmentIndex]
        tipControl.tintColor = defaultTint
        updateFields()
    }
    
    
    @IBAction func onTaxModeValueChanged(sender: AnyObject) {
        updateFields()
    }
    
    @IBAction func updateFields() {
        var billAmountDouble = 0.0
        if billField.text != nil && Double.init(billField.text!) != nil {
            billAmountDouble = Double.init(billField.text!)!
        }
        let isPreTaxMode = taxMode.selectedSegmentIndex == 0
        
        let percLabelString = percLabel.text!
        let tipRate = Double(percLabelString.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "%")))! / 100.0
        
        var tip = 0.0
        if isPreTaxMode {
            tip = billAmountDouble / 1.07 * tipRate
        } else {
            tip = billAmountDouble * tipRate
        }
        let total = billAmountDouble + tip

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    
}

