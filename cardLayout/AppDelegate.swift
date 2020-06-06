import Firebase
import UIKit


@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let greyColor: UIColor = UIColor(displayP3Red: 64/255, green: 65/255, blue: 66/255, alpha: 1)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: greyColor, NSAttributedStringKey.font: UIFont(name: "Gilroy-SemiBold", size: 15)!], for: UIControlState.normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: greyColor, NSAttributedStringKey.font : UIFont(name: "Gilroy-SemiBold", size: 15)! ], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: greyColor, NSAttributedStringKey.font : UIFont(name: "Gilroy-SemiBold", size: 15)! ], for: .focused)
        
        FirebaseApp.configure()
        
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "hasLaunched")
        
        if launchedBefore{
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad: UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
        } else {
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let initialViewControlleripad: UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Intro") as! IntroController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
        }
        
        
        return true
    }
    
    
    
}

