//
//  IntroLocationSetupController.swift
//  Converter lab
//
//  Created by Владислав Мартяк on 06.06.2020.
//  Copyright © 2020 Владислав Мартяк. All rights reserved.
//

import UIKit

class IntroLocationSetupController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func proceedToWelcome(_ sender: Any){
        if #available(iOS 13.0, *) {
            guard let secondViewController = storyboard?.instantiateViewController(identifier: "IntroWelcomeController") as? IntroWelcomeController else { return }
            secondViewController.modalPresentationStyle = .fullScreen
            secondViewController.modalTransitionStyle = .crossDissolve
            show(secondViewController, sender: nil)
        } else {
            // Fallback on earlier versions
        }
    }

}
