//
//  ViewController.swift
//  Pace_Mulitview_Linenfelser
//
//  Created by Andrew Linenfelser on 2/22/16.
//  Copyright © 2016 Andrew Linenfelser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var userDistance: UITextField!
    @IBOutlet weak var userHours: UITextField!
    @IBOutlet weak var userMinutes: UITextField!
    @IBOutlet weak var userSeconds: UITextField!
    @IBOutlet weak var paceLabel: UILabel!
    var paceMinPerMile: Double = 0.0
    //var pacePassValue: Double = 0.0
    var desiredTime: Float = 0.0

    @IBAction func getPaceButton(sender: AnyObject) {
        let d = (userDistance.text! as NSString).floatValue
        let h = (userHours.text! as NSString).floatValue
        let m = (userMinutes.text! as NSString).floatValue
        let s = (userSeconds.text! as NSString).floatValue
        
        let paceSec = (h * (60*60)) + (m * 60) + s
        let paceSecPerMile = paceSec/d
        let paceMinPerMile = paceSecPerMile/60
        //paceLabel.text = "\(paceMinPerMile)" + " min/mile"
        paceLabel.text = "\(paceMinPerMile)"
        
        desiredTime = (h*3600)+(m*60)+(s)
        }
    
    //http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewDidLoad() {
        //Looks for single or multiple taps.
        userDistance.keyboardType = UIKeyboardType.NumberPad
        userHours.keyboardType = UIKeyboardType.NumberPad
        userMinutes.keyboardType = UIKeyboardType.NumberPad
        userSeconds.keyboardType = UIKeyboardType.NumberPad
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DestViewController : ViewController2 = segue.destinationViewController as! ViewController2
        
        //pacePassValue = Double(paceMinPerMile)
        DestViewController.paceLabelText = paceLabel.text!
        DestViewController.paceValue = paceMinPerMile
        DestViewController.timeRemaining = desiredTime
//        DestViewController.paceValue = 10
    }


}

