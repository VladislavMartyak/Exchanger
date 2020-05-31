import UIKit
import MapKit

class OrganizationCell: UICollectionViewCell {
    
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    
    func setupCell(organization: Organization){
        organizationLabel.text = organization.title
        
        if let regionFull = regions[organization.regionId] {
            regionLabel.text = regionFull
        } else {
            regionLabel.text = "Недоступно"
        }
        
        if let cityFull = cities[organization.cityId] {
            cityLabel.text = cityFull
        } else {
            cityLabel.text = "Недоступно"
        }
        
        phoneLabel.text = organization.phone
        addressLabel.text = organization.address
        

        if let logo = UIImage(named: organization.title) {
            logoImage.image = logo

        } else {
            logoImage.backgroundColor = UIColor.white
        }
        
        createShadow()
    }
    
    func createShadow(){
        self.contentView.layer.cornerRadius = 4.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    @IBAction func openLink(_ sender: Any) {
        if let url = URL(string: "https://finance.ua/ua/") {
            UIApplication.shared.open(url)
        } else {
            print("Cannot open link")
        }
    }
    
    @IBAction func callNumber(_ sender: Any) {
        if let phoneCallURL = URL(string: "telprompt://\(phoneLabel.text ?? "123")") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func openMap(_ sender: Any) {
        
        let geocoder = CLGeocoder()
        let address = "\(cityLabel.text ?? "") \(addressLabel.text ?? "")"
        geocoder.geocodeAddressString(address) { placemarks, error in
            let placemark = placemarks?.first
            let destLat = placemark?.location?.coordinate.latitude
            let destLon = placemark?.location?.coordinate.longitude
            
            let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 49.8442183, longitude: 24.0262899)))
            source.name = "You"
            
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destLat ?? 0, longitude: destLon ?? 0)))
            destination.name = self.organizationLabel.text ?? "Банк"
            
            MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
    }
    
    
}
