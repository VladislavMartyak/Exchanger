//
//  IntroNotificationController.swift
//  Converter lab
//
//  Created by Владислав Мартяк on 06.06.2020.
//  Copyright © 2020 Владислав Мартяк. All rights reserved.
//

import UIKit
import UserNotifications

class IntroNotificationSetupController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func proceedToLocationSetup(_ sender: Any){
        allowAccessToNotifications()

        guard let secondViewController = storyboard?.instantiateViewController(withIdentifier: "IntroLocationSetupController") else { return }
        secondViewController.modalPresentationStyle = .fullScreen
        secondViewController.modalTransitionStyle = .crossDissolve
        show(secondViewController, sender: nil)

    }
    
    func allowAccessToNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                // Handle the error here.
            }
            // Provisional authorization granted.
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
