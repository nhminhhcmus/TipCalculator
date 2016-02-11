//
//  ViewController.swift
//  tips
//
//  Created by Minh Nguyen on 2/8/16.
//  Copyright © 2016 Minh Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var tipPercentages = [0.18 , 0.2 , 0.25];
    let defaults = NSUserDefaults.standardUserDefaults() // settings
    var isSettingSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTotal.alpha = 0
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text  = "$0.00"
        totalLabel.text = "$0.00"
        //set setting default
        if(defaults.objectForKey("bgColor") == nil) // setting colorbackground
        {
            print("set background color")
            defaults.setObject("White", forKey: "bgColor")
            isSettingSave = true
        }

    
        if(defaults.objectForKey("language") == nil) //setting language
        {
            print("set language")

            defaults.setObject("English", forKey: "language")
            isSettingSave = true

        }
        
        if(isSettingSave == true)
        {
            defaults.synchronize()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        //setting color
        let valueColor = defaults.objectForKey("bgColor")
        if(valueColor as! NSString == "Green")
        {
            self.view.backgroundColor = UIColor.greenColor()
        }
        else{
            self.view.backgroundColor = UIColor.whiteColor()
        }
        
        //setting language
        
        let languageValue = defaults.objectForKey("language")
        
        if(languageValue as! NSString == "English")
        {
            lblTip.text           = "Tip:"
            lblTotal.text         = "Total:"
            billAmountLabel.text  = "Bill Amount:"
         
        }
        else
        {
            billAmountLabel.text  = "Tổng hóa đơn:"
            lblTip.text           = "Tiền bo:"
            lblTotal.text         = "Tổng:"

        }
        
        // setting value percent
        let intValueOne = defaults.integerForKey(String(0))
        let valueOne = String(intValueOne)  +  "%"
        
        let intValueTwo = defaults.integerForKey(String(1))
        let valueTwo = String(intValueTwo)  +  "%"
        
        let intValueThree = defaults.integerForKey(String(2))
        let valueThree = String(intValueThree)  +  "%"
        
        if(intValueOne != 0 || intValueTwo != 0 || intValueThree != 0)
        {
            tipControl.setTitle(valueOne, forSegmentAtIndex: 0)
            tipControl.setTitle(valueTwo, forSegmentAtIndex: 1)
            tipControl.setTitle(valueThree, forSegmentAtIndex: 2)
            
            tipPercentages=[Double(intValueOne)*1.0/100,Double(intValueTwo)*1.0/100,Double(intValueThree)*1.0/100]
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
     
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
     

    }
    
    @IBAction func onDidBeginChange(sender: AnyObject) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.lblTotal.alpha = 1
            self.lblTotal.textColor = UIColor.redColor()
        }
    }

    @IBAction func onEdittingChange(sender: AnyObject) {
        
        let tipPercentage  = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount     = NSString(string: billField.text!).doubleValue
        let tips           = billAmount * tipPercentage
        let total          = billAmount + tips;
        
        tipLabel.text      = String(format: "$%.2f", tips)
        totalLabel.text    = String(format: "$%.2f", total)
        
    }

    @IBAction func onTap(sender: AnyObject) {
         view.endEditing(true)
    }
}

