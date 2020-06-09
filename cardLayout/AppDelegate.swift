import Firebase
import UIKit


@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        setUpUIBarButton()
        
        UserDefaults.standard.set(false, forKey: "hasLaunched")
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "hasLaunched")
        
        if launchedBefore{
            openViewController(storyboardName: "Main", viewContollerIndetifier: "NavigationController")
        } else {
            openViewController(storyboardName: "Onboarding", viewContollerIndetifier: "Intro")
        }
        return true
    }
    
    func setUpUIBarButton() {
        let greyColor: UIColor = UIColor(displayP3Red: 64/255, green: 65/255, blue: 66/255, alpha: 1)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: greyColor, NSAttributedStringKey.font: UIFont(name: "Gilroy-SemiBold", size: 15)!], for: UIControlState.normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: greyColor, NSAttributedStringKey.font : UIFont(name: "Gilroy-SemiBold", size: 15)! ], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: greyColor, NSAttributedStringKey.font : UIFont(name: "Gilroy-SemiBold", size: 15)! ], for: .focused)
    }
    
    func openViewController(storyboardName: String, viewContollerIndetifier: String) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: viewContollerIndetifier)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
    
}

