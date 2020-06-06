//
//  IntroMainController.swift
//  Converter lab
//
//  Created by Владислав Мартяк on 06.06.2020.
//  Copyright © 2020 Владислав Мартяк. All rights reserved.
//

import UIKit

class IntroController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func proceedToNotificationSetup(_ sender: Any){
        if #available(iOS 13.0, *) {
            guard let secondViewController = storyboard?.instantiateViewController(identifier: "IntroNotificationSetupController") as? IntroNotificationSetupController else { return }
            secondViewController.modalPresentationStyle = .fullScreen
            show(secondViewController, sender: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
