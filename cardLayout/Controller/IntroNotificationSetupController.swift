//
//  IntroNotificationController.swift
//  Converter lab
//
//  Created by Владислав Мартяк on 06.06.2020.
//  Copyright © 2020 Владислав Мартяк. All rights reserved.
//

import UIKit

class IntroNotificationSetupController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func proceedToLocationSetup(_ sender: Any){
        if #available(iOS 13.0, *) {
            guard let secondViewController = storyboard?.instantiateViewController(identifier: "IntroLocationSetupController") as? IntroLocationSetupController else { return }
            secondViewController.modalPresentationStyle = .fullScreen
            secondViewController.modalTransitionStyle = .crossDissolve
            show(secondViewController, sender: nil)
        } else {
            // Fallback on earlier versions
        }
    }

}
