//import Firebase
import UIKit


@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let greyColor: UIColor = UIColor(displayP3Red: 64/255, green: 65/255, blue: 66/255, alpha: 1)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: greyColor, NSAttributedStringKey.font: UIFont(name: "Gilroy-SemiBold", size: 15)!], for: UIControlState.normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: greyColor, NSAttributedStringKey.font : UIFont(name: "Gilroy-SemiBold", size: 15)! ], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: greyColor, NSAttributedStringKey.font : UIFont(name: "Gilroy-SemiBold", size: 15)! ], for: .focused)
        
        //FirebaseApp.configure()
        
        return true
    }
    
}

