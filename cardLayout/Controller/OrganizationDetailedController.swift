import UIKit

class OrganizationDetailedController: UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var currenciesTableView: UITableView!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var org: Organization?
    var currencies: [CurrencyFull] = []
    
    let currencyIndentifier = "currencyID"
    let greyColor: UIColor = UIColor(displayP3Red: 64/255, green: 65/255, blue: 66/255, alpha: 1)
    
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
        self.navigationController?.navigationBar.barTintColor = UIColor.white
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Gilroy-SemiBold", size: 17)!, NSAttributedString.Key.foregroundColor: greyColor]
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
    
    @IBAction func share (_ sender: Any){
        print("tapped share")
        let items: [Any] = ["\(org?.title ?? "") знаходиться на \(org?.address ?? ""), телефон: \(org?.phone ?? "")"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
}


extension OrganizationDetailedController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCurrency: CurrencyFull = currencies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyIndentifier, for: indexPath) as! CurrencyCell
        // Поправити
        cell.setup(shortName: currentCurrency.shortName, fullName: currentCurrency.fullName, ask: currentCurrency.ask, bid: currentCurrency.bid)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped on currency")
        let currentCurrency: CurrencyFull = currencies[indexPath.row]
        
        let askDouble = Double(currentCurrency.ask)
        let bidDouble = Double(currentCurrency.bid)
        let items: [Any] = ["\(currentCurrency.fullName): \(askDouble ?? 0)/\(bidDouble ?? 0) у \(org?.title ?? "")"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
        currenciesTableView.deselectRow(at: indexPath, animated: true)
    }

}


