import Foundation

struct Currency {
    let ask: String
    let bid: String
    
    init(json: [String: Any]) throws {
        guard let ask = json["ask"] as? String else { throw SerializationError.missing("ask is missimg")}
        guard let bid = json["bid"] as? String else { throw SerializationError.missing("bid is missimg")}
        
        self.ask = ask
        self.bid = bid
    }
}

struct CurrencyFull {
    // В цьому випадку композиція бо структури не наслідуться
    let concureny: Currency
    let shortName: String
    let fullName: String
    
    // інкапсуляція композиції
    var ask: String {
        concureny.ask
    }
    var bid: String {
        concureny.bid
    }
}

let currenciesDictionary: [String: String] = ["AED" : "Дирхам ОАЕ",
                                              "AMD" : "Вірменський драм",
                                              "AUD" : "Австралійський долар",
                                              "AZN" : "Азербайджанський манат",
                                              "BGN" : "Болгарський лев",
                                              "BRL" : "Бразильський реал",
                                              "BYN" : "Білоруський рубель",
                                              "CAD" : "Канадський долар",
                                              "CHF" : "Швейцарський франк",
                                              "CLP" : "Чилійський песо",
                                              "CNY" : "Юань Женьміньбі",
                                              "CZK" : "Чеська крона",
                                              "DKK" : "Данська крона",
                                              "DZD" : "Алжирський динар",
                                              "EGP" : "Єгипетський фунт",
                                              "EUR" : "Євро",
                                              "GBP" : "Фунт стерлінгів",
                                              "GEL" : "Грузинський ларі",
                                              "HKD" : "Гонконгський долар",
                                              "HRK" : "Хорватська куна",
                                              "HUF" : "Угорський форинт",
                                              "ILS" : "Ізраїльський  шекель",
                                              "INR" : "Індійська рупія",
                                              "IQD" : "Іракський динар",
                                              "JPY" : "Єна",
                                              "KGS" : "Киргизький сом",
                                              "KRW" : "Південнокорейська вона",
                                              "KWD" : "Кувейтський динар",
                                              "KZT" : "Казахстанський теньге",
                                              "LBP" : "Ліванський фунт",
                                              "MDL" : "Молдовський лей",
                                              "MXN" : "Мексиканський песо",
                                              "NOK" : "Норвезька крона",
                                              "NZD" : "Новозеландський долар",
                                              "PKR" : "Пакистанська рупія",
                                              "PLN" : "Польський Злотий",
                                              "RON" : "Румунський лей",
                                              "RUB" : "Російський рублю",
                                              "SAR" : "Саудівський ріал",
                                              "SEK" : "Шведська крона",
                                              "SGD" : "Сінгапурський долар",
                                              "THB" : "Тайський бат",
                                              "TJS" : "Таджицький сомоні",
                                              "TMT" : "Туркменський манат",
                                              "TWD" : "Новий тайванський долар",
                                              "USD" : "Долар США",
                                              "VND" : "В'єтнамський донг"]

