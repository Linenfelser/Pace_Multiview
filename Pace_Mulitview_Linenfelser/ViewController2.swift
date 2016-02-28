//
//  ViewController2.swift
//  Pace_Mulitview_Linenfelser
//
//  Created by Andrew Linenfelser on 2/22/16.
//  Copyright © 2016 Andrew Linenfelser. All rights reserved.
//

import UIKit
import CoreLocation
import AudioToolbox

class ViewController2: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var paceLabel2: UILabel!
    @IBOutlet weak var userPaceLabel: UILabel!
    @IBOutlet weak var userDistanceTraveledLabel: UILabel!
    @IBOutlet weak var averagePaceLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var mySpeed = 0.0
    var myPace = 0.0
    var mySpeedTemp = 0.0
    
    var paceLabelText = String()
    var paceValue: Double = 0.0
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var distanceTraveled: Double = 0.0
    var distanceTraveledMiles: Double = 0.0
    
    
    var myTimer = NSTimer()
    var myValue = false
    var paceAverage: Double = 0.0
    var paceAverageFinal: Double = 0.0
    var counter = 0
    
    @IBAction func runValue(sender: AnyObject) {
        myValue = true
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        print("lcoations = \(locValue.latitude) \(locValue.longitude)")
        
        mySpeed = locationManager.location!.speed
        //convert mps to mph
        mySpeed *= 2.2394
        speedLabel.text = "\(mySpeed)" + " mph"
        
        mySpeedTemp = mySpeed/60
        
        
        
        //not moving... cant div by 0
        if mySpeed == 0{
            userPaceLabel.text = "\(0)" + " minute mile (mpm)"
        }else{
            myPace = 1/mySpeed //hours per mile
            myPace *= 60 //minutes per mile
            
//            print("____mySpeed____", mySpeed)
//            print("____myPace_____", myPace)
            userPaceLabel.text = "\(myPace)" + " minute mile"
            
            
        }
        
        if myValue == false{
            print("not running")
            myPace = 0.0
            mySpeed = 0.0
        }else{
            //get the distance traveled
            if startLocation == nil {
                startLocation = locations.first! as CLLocation
                
            } else {
                //start updating distance
                let lastLocation = locations.last! as CLLocation
                let distance = startLocation.distanceFromLocation(lastLocation)
                startLocation = lastLocation
                distanceTraveled += distance
                distanceTraveledMiles = distanceTraveled * 0.000621371
                //print("__distanceTraveledAFTERconversion__", distanceTraveled)
                userDistanceTraveledLabel.text = "\(distanceTraveledMiles)"
                
                counter++
                print("_____COUNTER_____", counter)
                paceAverage += myPace //divide by counter is below... need to cast to doubles
                // if the user is not running
                print("___myPace)__", myPace)
                print("__paceAverage__", paceAverage)
                paceAverageFinal = Double(paceAverage) / Double(counter)
                
                print("\n")
                print("___paceAverageFinal", paceAverageFinal)
                
                averagePaceLabel.text = "\(paceAverageFinal)"
                print("______paceValue", paceValue)
                print("\n")
                if(counter%10 == 0){
                    if(paceAverageFinal > paceValue){
                        alertUserTooSlow()
                    }
                }
            }
        }
        //counter++
    }
    
    func alertUserTooSlow(){
        print("bla")
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    
    override func viewDidLoad() {
        //var myTimer = NSTimer()
        
        super.viewDidLoad()
        
        paceLabel2.text = paceLabelText
        
        // Do any additional setup after loading the view.
        paceValue = Double(paceLabelText)!
        self.locationManager.requestAlwaysAuthorization()
        //for use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
