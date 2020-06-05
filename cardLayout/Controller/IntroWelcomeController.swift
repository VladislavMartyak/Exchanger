//
//  IntroWelcomeController.swift
//  Converter lab
//
//  Created by Владислав Мартяк on 06.06.2020.
//  Copyright © 2020 Владислав Мартяк. All rights reserved.
//

import UIKit

class IntroWelcomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func proceedToMainApp(_ sender: Any){
        if #available(iOS 13.0, *) {
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad: UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
            
            initialViewControlleripad.modalPresentationStyle = .fullScreen
            self.present(initialViewControlleripad, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }

}
