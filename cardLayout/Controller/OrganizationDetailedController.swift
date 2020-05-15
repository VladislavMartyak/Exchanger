import UIKit

class OrganizationDetailedController: UIViewController {
    
    let currencyIndentifier = "currencyID"
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var currenciesTableView: UITableView!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    var org: Organization?
    
    var currencies: [CurrencyFull] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        convertCurrencies()
        
        if let org = org?.title{
            organizationLabel.text = org
        }
        
        if let logo = UIImage(named: org?.title ?? ""){
            logoView.image = logo
        } else {
            logoView.backgroundColor = UIColor.white
        }
        detailsLabel.text = "Oфіційний сайт:\nwww.bank.ua/ua\nІнтернет-банкінг: Мій \(org?.title ?? "")\nАдреса: \(org?.address ?? "")\nГаряча лінія: \(org?.phone ?? "")\n(цілодобово без вихідних)\nТелефон: \(org?.phone ?? "")4\n(дзвінки з-за кордону)\ne-mail: ccd@bank.kiev.ua"
        
        currenciesTableView.delegate = self
        currenciesTableView.dataSource = self
    }
    
    func setUpNavigationBar() {
         self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 17)!, NSAttributedString.Key.foregroundColor:UIColor.white]
        self.title = org?.title
     }
    
    func convertCurrencies(){
        if let newDic: [String: Currency] = org?.currencies {
            for (currency, askbid) in newDic {
                let fullName: String
                if let name = currenciesDictionary[currency]{
                    fullName = name
                } else {
                    fullName = "Невідомо"
                }
                let newCurrency: CurrencyFull = CurrencyFull(concureny: askbid, shortName: currency, fullName: fullName)
                currencies.append(newCurrency)
            }
        }
    }
    
}


extension OrganizationDetailedController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCurrency: CurrencyFull = currencies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyIndentifier, for: indexPath) as! CurrencyCell
        // Аналог пройоб 2
        cell.setup(shortName: currentCurrency.shortName, fullName: currentCurrency.fullName, ask: currentCurrency.ask, bid: currentCurrency.bid)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currenciesTableView.deselectRow(at: indexPath, animated: true)
    }

}


