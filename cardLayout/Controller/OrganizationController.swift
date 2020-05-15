import UIKit
import Network



final class OrganizationController: UIViewController {
    
    @IBOutlet weak var organizationsCollectionView: UICollectionView!
    
    var arrayTest: [Organization] = []
    let cellIdentifier = "organizationID"
    let url = URL(string: "http://resources.finance.ua/ua/public/currency-cash.json")
    
    override func viewDidLoad() {
        setUpNavigationBar()
        setupCollectionView()
        downloadJSON()
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
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 17)!, NSAttributedString.Key.foregroundColor:UIColor.black]
        self.title = "Exhanger"
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

