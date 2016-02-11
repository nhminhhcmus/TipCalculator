//
//  SettingsViewController.swift
//  tips
//
//  Created by Minh Nguyen on 2/9/16.
//  Copyright © 2016 Minh Nguyen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController , SSRadioButtonControllerDelegate,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var lblBgColor: UILabel!
    
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblPercent: UILabel!
    @IBOutlet weak var btnGreen     : UIButton!
    @IBOutlet weak var btnWhite     : UIButton!
    @IBOutlet weak var picker       : UIPickerView!
    @IBOutlet weak var btnVietnamese: SSRadioButton!
    @IBOutlet weak var btnEnglish   : SSRadioButton!
    
    var radioButtonBackGroundColor  : SSRadioButtonsController?
    var radioButtonLanguage         : SSRadioButtonsController?

    var pickerData = ["Value 1","Value 2","Value 3"] // data picker
    var rowPickPercent : Int = 42

    let defaults = NSUserDefaults.standardUserDefaults() // settings


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Choose color for app
        radioButtonBackGroundColor = SSRadioButtonsController(buttons: btnGreen, btnWhite)
        radioButtonBackGroundColor!.delegate = self
        radioButtonBackGroundColor!.shouldLetDeSelect = true
        let valueColor = defaults.objectForKey("bgColor")
        if(valueColor as! NSString == "Green")
        {
            radioButtonBackGroundColor!.pressed(btnGreen)
        }
        else{
            radioButtonBackGroundColor!.pressed(btnWhite)
        }

        
        // choose language
        radioButtonLanguage = SSRadioButtonsController(buttons: btnVietnamese, btnEnglish)
        radioButtonLanguage!.delegate = self
        radioButtonLanguage!.shouldLetDeSelect = true
        let language = defaults.objectForKey("language")
        if(language as! NSString == "English")
        {
            radioButtonLanguage!.pressed(btnEnglish)
        }
        else{
            radioButtonLanguage!.pressed(btnVietnamese)
        }
        
        //data source picker percent
        picker.dataSource = self
        picker.delegate = self
        

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Data source and Delegate PickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        rowPickPercent = row;
        let intValue = defaults.integerForKey(String(rowPickPercent))

        switch row
        {
        case 0:
            if(intValue == 0)
            {
                txtValue.text =  String(18)
            }
            else
            {
                txtValue.text =  String(intValue)
            }
        case 1:
            if(intValue == 0)
            {
                txtValue.text =  String(20)
            }
            else
            {
                txtValue.text =  String(intValue)
            }
        case 2:
            if(intValue == 0)
            {
                txtValue.text =  String(25)
            }
            else
            {
                txtValue.text =  String(intValue)
            }
        default:break
        }
        return pickerData[row]
    }
    //


    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)

    }
    
    func didSelectButton(aButton: UIButton?) {
        // save setting background color
        switch aButton!
        {
        case btnGreen:
                print("Green")
                defaults.setObject(aButton?.currentTitle, forKey: "bgColor")
                self.view.backgroundColor = UIColor.greenColor()


        case btnWhite:
            print("white")
            defaults.setObject(aButton?.currentTitle, forKey: "bgColor")
            self.view.backgroundColor = UIColor.whiteColor()


        case btnVietnamese:
            print("Vietnamese")
            defaults.setObject(aButton?.currentTitle, forKey: "language")
            btnGreen.setTitle("Xanh", forState: .Normal)
            btnWhite.setTitle("Trắng", forState: .Normal)
            lblBgColor.text = "Phong nền:"
            lblPercent.text = "Phần trăm:"
            lblLanguage.text = "Ngôn ngữ"
            pickerData = ["Giá trị 1","Giá trị 2","Giá trị 3"]
            [picker .reloadAllComponents()]

        case btnEnglish:
            print("English")
            defaults.setObject(aButton?.currentTitle, forKey: "language")
            btnGreen.setTitle("Green", forState: .Normal)
            btnWhite.setTitle("White", forState: .Normal)
            lblBgColor.text = "BackGround Color:"
            lblPercent.text = "Percentage:"
            lblLanguage.text = "Language:"
            pickerData = ["Value 1","Value 2","Value 3"]
            [picker .reloadAllComponents()]

        default:
            break
            
        }
        defaults.synchronize()


    }
    @IBAction func onValuePercentChange(sender: AnyObject) {
        if(txtValue.text != "")
        {
            var a = txtValue.text;

            if(Int(a!)! > 100)
            {
                txtValue.text = "100"
                a = txtValue.text
            }
            defaults.setInteger(Int(a!)!, forKey: String(rowPickPercent))
            defaults.synchronize()

        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
