import UIKit
import Network
import UserNotifications
import FirebaseCrashlytics


final class OrganizationController: UIViewController {
    
   
    @IBOutlet weak var organizationsCollectionView: UICollectionView!
    @IBOutlet weak var startButton: UIBarButtonItem!
    
    let greyColor: UIColor = UIColor(displayP3Red: 64/255, green: 65/255, blue: 66/255, alpha: 1)
    
    var arrayTest: [Organization] = []
    let cellIdentifier = "organizationID"
    let url = URL(string: "http://resources.finance.ua/ua/public/currency-cash.json")
    
    override func viewDidLoad() {
        setUpNavigationBar()
        setupCollectionView()
        downloadJSON()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            //Reuqest
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Оновлення курсу валют"
        content.body = "Оновилися курси валют, зайдіть у додаток, щоб переглянути їх!"
        
        let date = Date().addingTimeInterval(10)
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            //Check
        }
    }
    
    private func setupCollectionView() {
        organizationsCollectionView.register(cellType: OrganizationCell.self)
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
    
    
    @IBAction func showStarredlist(_ sender: Any){
        let alert = UIAlertController(title: "Чекайте оновлень", message: "Дана функція уже у розробці, тому слідкуйте за новинами, щоб бути першим, хто про це дізнається!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Зрозуміло", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

//MARK: - Functions

extension OrganizationController{
    
    func downloadJSON() {
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
        
    
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Gilroy-SemiBold", size: 34)!, NSAttributedString.Key.foregroundColor: greyColor]
    
        } else {
            // Fallback on earlier versions
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Gilroy-SemiBold", size: 17)!, NSAttributedString.Key.foregroundColor: greyColor]
        self.title = "Exchanger"
    }
    
    
    
}



//MARK: - Extensions

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

