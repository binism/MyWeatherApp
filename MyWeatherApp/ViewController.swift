//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Wu Binbin on 5/24/16.
//  Copyright © 2016 Wu Binbin. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    //MARK:@IBOut Today
    //UserLocation
    @IBOutlet weak var UserLocationLabel: UILabel!
    
    //SummaryStackView
    @IBOutlet weak var SummaryIcon: UIImageView!
    @IBOutlet weak var SummaryLabel: UILabel!
    
    //CurrentTemrature
    @IBOutlet weak var CurrentTempratureLabel: UILabel!
    
    //TodayHighTempStackView
    @IBOutlet weak var TodayHighTemperature: UILabel!
    @IBOutlet weak var TodayHighTemperatureLabel: UILabel!
    
    //TodayLowTempStackView
    @IBOutlet weak var TodayLowTemperature: UILabel!
    @IBOutlet weak var TodayLowTemperatureLabel: UILabel!
    
    //HeatIndexImg
    @IBOutlet weak var HeatIndexImg: UIImageView!
    
    //windbag&WindStackView
    @IBOutlet weak var windbagImg: UIImageView!
    @IBOutlet weak var WindIndex: UILabel!
    @IBOutlet weak var WindLabel: UILabel!
    
    //umbrella&RainStackView
    @IBOutlet weak var umbrellaImg: UIImageView!
    @IBOutlet weak var RainIndex: UILabel!
    @IBOutlet weak var RainLabel: UILabel!
    
    //humidity&HumidityStackView
    @IBOutlet weak var humidityImg: UIImageView!
    @IBOutlet weak var HumidityIndex: UILabel!
    @IBOutlet weak var HumidityLabel: UILabel!
    
    
    //MARK:@IBOutlet weekday
    
    //1stDayStackView
    @IBOutlet weak var DayOneWeekDay: UILabel!
    @IBOutlet weak var DayOneImg: UIImageView!
    @IBOutlet weak var DayOneHighLowTemp: UILabel!
    
    //2ndDayStackView
    @IBOutlet weak var DayTwoWeekDay: UILabel!
    @IBOutlet weak var DayTwoImg: UIImageView!
    @IBOutlet weak var DayTwoHighLowTemp: UILabel!
    
    //3rdDayStackView
    @IBOutlet weak var DayThreeWeekDaty: UILabel!
    @IBOutlet weak var DayThreeImg: UIImageView!
    @IBOutlet weak var DayThreeHighLowTemp: UILabel!
    
    //4thDayStackView
    @IBOutlet weak var DayFourWeekDay: UILabel!
    @IBOutlet weak var DayFourImg: UIImageView!
    @IBOutlet weak var DayFourHignLowTemp: UILabel!
    
    //5thDayStackView
    @IBOutlet weak var DayFiveWeekDay: UILabel!
    @IBOutlet weak var DayFiveImg: UIImageView!
    @IBOutlet weak var DayFiveHighLowTemp: UILabel!
    
    //6thDayStackView
    @IBOutlet weak var DaySixWeekDay: UILabel!
    @IBOutlet weak var DaySixImg: UIImageView!
    @IBOutlet weak var DaySixHighLowTemp: UILabel!
    
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    var locationManager: CLLocationManager!
    var userLocation : String!
    var userLatitude : Double!
    var userLongitude : Double!
    var userTemperatureCelsius : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initLocationManager()
    }
    func initLocationManager() {
        seenError = false
        locationFixAchieved = false
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            let pm = placemarks![0]
            self.displayLocationInfo(pm)
        })
        
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as! CLLocation
            var coord = locationObj.coordinate
            self.userLatitude = coord.latitude
            self.userLongitude = coord.longitude
            //
            //getCurrentWeatherData()
            
            
        }
    }
    func displayLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            print(locality)
            print(postalCode)
            print(administrativeArea)
            print(country)
            
            self.UserLocationLabel.text = locality
            
        }
    }
    
    func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        
        switch status {
        case CLAuthorizationStatus.Restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.Denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.NotDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

