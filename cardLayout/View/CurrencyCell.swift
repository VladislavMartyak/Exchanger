import UIKit

class CurrencyCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var currencyShortLabel: UILabel!
    @IBOutlet weak var currencyFullLabel: UILabel!
    @IBOutlet weak var currencyAskLabel: UILabel!
    @IBOutlet weak var currencyBidLabel: UILabel!
    
    // MARK: Functions
    func setup(shortName: String, fullName: String, ask: String, bid: String) {
        currencyShortLabel.text = shortName
        currencyFullLabel.text = fullName
        currencyAskLabel.text = ask
        currencyBidLabel.text = bid
    }

}
