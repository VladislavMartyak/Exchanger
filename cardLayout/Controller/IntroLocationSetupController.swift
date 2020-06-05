//
//  IntroLocationSetupController.swift
//  Converter lab
//
//  Created by Владислав Мартяк on 06.06.2020.
//  Copyright © 2020 Владислав Мартяк. All rights reserved.
//

import UIKit
import CoreLocation

class IntroLocationSetupController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func proceedToWelcome(_ sender: Any){
        
        allowAccessToLocation()
        
        if #available(iOS 13.0, *) {
            guard let secondViewController = storyboard?.instantiateViewController(identifier: "IntroWelcomeController") as? IntroWelcomeController else { return }
            secondViewController.modalPresentationStyle = .fullScreen
            secondViewController.modalTransitionStyle = .crossDissolve
            show(secondViewController, sender: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func allowAccessToLocation(){
        let locStatus = CLLocationManager.authorizationStatus()
        switch locStatus {
           case .notDetermined:
              locationManager.requestWhenInUseAuthorization()
           return
           case .denied, .restricted:
              let alert = UIAlertController(title: "Location Services are disabled", message: "Please enable Location Services in your Settings", preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              alert.addAction(okAction)
              present(alert, animated: true, completion: nil)
           return
           case .authorizedAlways, .authorizedWhenInUse:
           break
        }
    }

}
