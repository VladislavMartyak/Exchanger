import UIKit
import Network
import UserNotifications
import FirebaseCrashlytics
import Reachability


final class OrganizationController: UIViewController {
   
    // MARK: Outlets
    @IBOutlet weak var organizationsCollectionView: UICollectionView!
    @IBOutlet weak var startButton: UIBarButtonItem!

    
    // MARK: Variables
    var arrayTest: [Organization] = []
    
    // MARK: Constants
    let cellIdentifier = "organizationID"
    let url = URL(string: "http://resources.finance.ua/ua/public/currency-cash.json")
    let greyColor: UIColor = UIColor(displayP3Red: 64/255, green: 65/255, blue: 66/255, alpha: 1)
   
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        
        setUpNavigationBar()
        setupCollectionView()
        downloadJSON()
        setUpNotification(title: "Оновлення курсу валют", body: "Оновилися курси валют, зайдіть у додаток, щоб переглянути їх!")
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateList), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
    }
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "organizationInfo" {
            let newViewController = segue.destination as! OrganizationDetailedController
            let indexPath = sender as! NSIndexPath
            let obj = arrayTest[indexPath.row]
            newViewController.org = obj
        }
    }
    
    // MARK: - Actions
    @IBAction func showStarredlist(_ sender: Any){
        showSimpleAlert(title: "Чекайте оновлень", message: "Дана функція уже у розробці, тому слідкуйте за новинами, щоб бути першим, хто про це дізнається!", buttonTitle: "Зрозуміло")
    }
}

//MARK: - Functions
extension OrganizationController{
    
    private func setupCollectionView() {
        organizationsCollectionView.register(cellType: OrganizationCell.self)
    }
    
    private func downloadJSON() {
        guard let dowloadURL = url else { return }
        URLSession.shared.dataTask(with: dowloadURL) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("Something went wrong")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let jsonStrong = json,
                let organizations = jsonStrong["organizations"] as? [[String: Any]]
                else {
                    return
            }
            
            for org in organizations {
                guard let currencies = org["currencies"] as? [String: Any],
                    var organizationObject = try? Organization(json: org)
                    else {
                        continue
                }
                for (key, value) in currencies{
                    if let currencyObject = try? Currency(json: value as! [String : Any]) {
                        organizationObject.currencies[key] = currencyObject
                    }
                    
                }
                self.arrayTest.append(organizationObject)
            }
            
            DispatchQueue.main.async {
                self.organizationsCollectionView.reloadData()
            }
        }.resume()
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Gilroy-SemiBold", size: 34)!, NSAttributedString.Key.foregroundColor: greyColor]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Gilroy-SemiBold", size: 17)!, NSAttributedString.Key.foregroundColor: greyColor]
        self.title = "Exchanger"
    }
    
    func showSimpleAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func setUpNotification(title: String, body: String){
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let date = Date().addingTimeInterval(5)
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            //Check
        }
    }
    
    func isInternetConnected() -> Bool {
        let reachability = try! Reachability()
        switch reachability.connection {
        case .cellular:
            return true
        case .wifi:
            return true
        case .unavailable:
            return false
        default:
            return false
        }
    }
    
    @objc func updateList(){
        if isInternetConnected() == true {
            downloadJSON()
            setUpNotification(title: "Оновлення курсу валют", body: "Оновилися курси валют, зайдіть у додаток, щоб переглянути їх!")
        } else {
            showSimpleAlert(title: "Відсутнє з'єднання з інтернетом", message: "", buttonTitle: "Зрозуміло")
        }
    }
    
}

extension OrganizationController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let organization: Organization = arrayTest[indexPath.row]
        
        let cell = collectionView.cell(cellType: OrganizationCell.self, for: indexPath)
        
        cell.setupCell(organization: organization)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "organizationInfo", sender: indexPath)
    }
}

