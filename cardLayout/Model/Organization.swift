import Foundation

struct Organization {
    
    let title: String
    let regionId: String
    let cityId: String
    let phone: String?
    let address: String
    let link: String
    var currencies: [String: Currency]

    init(json: [String: Any]) throws {
        guard let title = json["title"] as? String else { throw SerializationError.missing("title is missimg")}
        guard let regionId = json["regionId"] as? String else { throw SerializationError.missing("regionID is missimg")}
        guard let cityId = json["cityId"] as? String else { throw SerializationError.missing("cityID is missimg")}
        guard let phone = json["phone"] as? String? else { throw SerializationError.missing("phone is missimg")}
        guard let address = json["address"] as? String else { throw SerializationError.missing("address is missimg")}
        guard let link = json["link"] as? String else { throw SerializationError.missing("link is missimg")}
        
        self.title = title
        self.regionId = regionId
        self.cityId = cityId
        self.phone = phone
        self.address = address
        self.link = link
        self.currencies = [:]
    }
    
}

