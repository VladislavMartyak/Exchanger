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
    }
    
    @IBAction func proceedToMainApp(_ sender: Any){
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationController")
            
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "hasLaunched")

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
