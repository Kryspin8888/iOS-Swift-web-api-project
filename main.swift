import Foundation

struct Currency : Decodable{
  var code: String
  var name: String
  var symbol: String
}

struct Language : Decodable{
  var iso639_1: String
  var iso639_2: String
  var name: String
  var nativeName: String
}

struct RegionalBloc : Decodable{
  var acronym: String
  var name: String
  var otherAcronyms: [String]
  var otherNames: [String]
}

struct Country: Decodable {
    var name:String
    var topLevelDomain:[String]
    var alpha2Code:String
    var alpha3Code:String
    var callingCodes:[String]
    var capital:String
    var altSpellings:[String]
    var region:String
    var subregion:String
    var population:Int
    var latlng:[Double]
    var demonym:String
    var area:Double
    var gini:Double?
    var timezones:[String]
    var borders:[String]
    var nativeName:String
    var numericCode:String
    var currencies:[Currency]
    var languages:[Language]
    var de:String
    var es:String
    var fr:String
    var ja:String
    var it:String
    var br:String
    var pt:String
    var nl:String
    var hr:String
    var fa:String

    enum TranslationsKey: String, CodingKey {
        case de
        case es
        case fr
        case ja
        case it
        case br
        case pt
        case nl
        case hr
        case fa
    }

    var flag:String   
    var regionalBlocs:[RegionalBloc]
    var cioc:String

    enum CodingKeys: String, CodingKey {
        case name
        case topLevelDomain
        case alpha2Code
        case alpha3Code
        case callingCodes
        case capital
        case altSpellings
        case region
        case subregion
        case population
        case latlng
        case demonym
        case area
        case gini
        case timezones
        case borders
        case nativeName
        case numericCode
        case currencies
        case languages
        case translations
        case flag
        case regionalBlocs
        case cioc
    }

    // JSON to model object
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try values.decode(String.self, forKey: .name)
        topLevelDomain = try values.decode([String].self, forKey: .topLevelDomain)
        alpha2Code = try values.decode(String.self, forKey: .alpha2Code)
        alpha3Code = try values.decode(String.self, forKey: .alpha3Code)
        callingCodes = try values.decode([String].self, forKey: .callingCodes)
        capital = try values.decode(String.self, forKey: .capital)
        altSpellings = try values.decode([String].self, forKey: .altSpellings)
        region = try values.decode(String.self, forKey: .region)
        subregion = try values.decode(String.self, forKey: .subregion)
        population = try values.decode(Int.self, forKey: .population)
        latlng = try values.decode([Double].self, forKey: .latlng)
        demonym = try values.decode(String.self, forKey: .demonym)
        area = try values.decode(Double.self, forKey: .area)

        gini = try values.decodeIfPresent(Double.self, forKey: .gini)

        timezones = try values.decode([String].self, forKey: .timezones)
        borders = try values.decode([String].self, forKey: .borders)
        nativeName = try values.decode(String.self, forKey: .nativeName)
        numericCode = try values.decode(String.self, forKey: .numericCode)
        currencies = try values.decode([Currency].self, forKey: .currencies)
        languages = try values.decode([Language].self, forKey: .languages)

        let translations = try values.nestedContainer(keyedBy: TranslationsKey.self, forKey: .translations)
        de = try translations.decode(String.self, forKey: .de)
        es = try translations.decode(String.self, forKey: .es)
        fr = try translations.decode(String.self, forKey: .fr)
        ja = try translations.decode(String.self, forKey: .ja)
        it = try translations.decode(String.self, forKey: .it)
        br = try translations.decode(String.self, forKey: .br)
        pt = try translations.decode(String.self, forKey: .pt)
        nl = try translations.decode(String.self, forKey: .nl)
        hr = try translations.decode(String.self, forKey: .hr)
        fa = try translations.decode(String.self, forKey: .fa)
      
        flag = try values.decode(String.self, forKey: .flag)
        regionalBlocs = try values.decode([RegionalBloc].self, forKey: .regionalBlocs)
        cioc = try values.decode(String.self, forKey: .cioc)        
    }
}

func printStringArray(stringArray: [String]) -> String {

    var string = ""

    for word in stringArray{

      string += "\n\t\t\t\t\t\t\t\t\t" + word
    }

    if(string == ""){

     string = "\n\t\t\t\t\t\t\t\t\t<brak>"
     
    }

    return string + "\n"
}

func printLatLonArray(doubleArray: [Double]) -> String {

    var string = ""

    if(doubleArray[0] >= 0.0){
      string += String(doubleArray[0]) + " N \t"
    }
    else{
      string += String(doubleArray[0] * -1.0) + " S \t"
    }

    if(doubleArray[1] >= 0.0){
      string += String(doubleArray[1]) + " E \t"
    }
    else{
      string += String(doubleArray[1] * -1.0) + " W \t"
    }

    return string
}

func printCurrenciesArray(currenciesArray: [Currency]) -> String {

    var string = ""

    for currency in currenciesArray{

      string += """

      \t\tkod waluty: \t\t\t\t\(currency.code)
      \t\tnazwa: \t\t\t\t\t\t\(currency.name)
      \t\tsymbol: \t\t\t\t\t\(currency.symbol)
      """
    }

    return string + "\n"
}

func printLanguagesArray(languagesArray: [Language]) -> String {

    var string = ""

    for language in languagesArray{

      string += """

      \t\tnazwa: \t\t\t\t\t\t\(language.name)
      \t\tnazwa rodzima: \t\t\t\t\(language.nativeName)
      \t\tkod iso639_1: \t\t\t\t\(language.iso639_1)
      \t\tkod iso639_2: \t\t\t\t\(language.iso639_2)
      
      """
    }

    return string 
}

func printTimezonesArray(stringArray: [String]) -> String {

    var string = ""

    for word in stringArray{

      let temp = NSMutableString(string: word)
      temp.insert(" ", at: 3)
      string += "\n\t\t\t\t\t\t\t\t\t" + (temp as String)
    }

    return string + "\n"
}

func printIfNotNull(double: Double?) -> String {

    if let a = double{
      return String(a)
    }
    else{
      return "<brak danych>"
    }
}

func printCallingCodesArray(stringArray: [String]) -> String {

    var string = ""

    for word in stringArray{

      string += "\n\t\t\t\t\t\t\t\t\t+ " + word
    }

    return string + "\n"
}

func printTranslations(country: Country) -> String {

    let string = """

    \t\tniemiecki: \t\t\t\t\t\(country.de)
    \t\thiszpański: \t\t\t\t\(country.es)
    \t\tfrancuski: \t\t\t\t\t\(country.fr)
    \t\tjapoński: \t\t\t\t\t\(country.ja)
    \t\twłoski: \t\t\t\t\t\(country.it)
    \t\tbretoński: \t\t\t\t\t\(country.br)
    \t\tportugalski: \t\t\t\t\(country.it)
    \t\tholenderski: \t\t\t\t\(country.nl)
    \t\tchorwacki: \t\t\t\t\t\(country.hr)
    \t\tperski: \t\t\t\t\t\(country.fa)
    """

    return string + "\n"
}

func printRegionalBlocs(regionalBlocsArray: [RegionalBloc]) -> String {

    var string = ""

    for bloc in regionalBlocsArray{

      string += """

      \t\tnazwa: \t\t\t\t\t\t\(bloc.name)
      \t\takronim: \t\t\t\t\t\(bloc.acronym)
      \t\tinne nazwy: \(printStringArray(stringArray: bloc.otherNames))
      \t\tinne akronimy: \(printStringArray(stringArray: bloc.otherAcronyms))
      """
    }

    return string
}


func printCountriesData(countries: [Country]) -> String {

    var string = ""
    let numberFormatter = NumberFormatter()
    numberFormatter.groupingSeparator = " "
    numberFormatter.numberStyle = .decimal

    for country in countries{

      string += """

      Nazwa państwa: \t\t\t\t\t\t\(country.name) 
      Domeny: \(printStringArray(stringArray: country.topLevelDomain))
      Kod alfa-2: \t\t\t\t\t\t\(country.alpha2Code) 
      Kod alfa-3: \t\t\t\t\t\t\(country.alpha3Code) 
      Kody telefoniczne: \(printCallingCodesArray(stringArray: country.callingCodes))
      Stolica: \t\t\t\t\t\t\t\(country.capital) 
      Nazwy alternatywne: \(printStringArray(stringArray: country.altSpellings))
      Region: \t\t\t\t\t\t\t\(country.region)
      Podregion: \t\t\t\t\t\t\t\(country.subregion)
      Populacja: \t\t\t\t\t\t\t\(numberFormatter.string(from: NSNumber(value: country.population))!) osób
      Szerokość/Długość geograficzna: \t\(printLatLonArray(doubleArray: country.latlng))
      Demonim: \t\t\t\t\t\t\t\(country.demonym)
      Powierzchnia: \t\t\t\t\t\t\((numberFormatter.string(from: NSNumber(value: country.area))!)) km^2
      Wskaźnik nierówności społecznej: \t\(printIfNotNull(double: country.gini))
      Strefy czasowe: \(printTimezonesArray(stringArray: country.timezones))
      Państwa graniczne: \(printStringArray(stringArray: country.borders))
      Nazwa rodzima: \t\t\t\t\t\t\(country.nativeName)
      Kod numeryczny: \t\t\t\t\t\(country.numericCode)
      Waluty: \(printCurrenciesArray(currenciesArray: country.currencies))
      Języki: \(printLanguagesArray(languagesArray: country.languages))
      Tłumaczenia nazwy państwa: \(printTranslations(country: country))
      Flaga (adres): \t\t\t\t\t\(country.flag)
      Bloki regionalne: \(printRegionalBlocs(regionalBlocsArray: country.regionalBlocs))
      Skrót nazwy państwa: \t\t\t\t\(country.cioc != "" ? country.cioc : "<brak>")
      \n\n\n\n
      """
    }

    return string
}

//from request https://restcountries.eu/rest/v2/name/pol
let testJSON = "[{\"name\":\"French Polynesia\",\"topLevelDomain\":[\".pf\"],\"alpha2Code\":\"PF\",\"alpha3Code\":\"PYF\",\"callingCodes\":[\"689\"],\"capital\":\"Papeetē\",\"altSpellings\":[\"PF\",\"Polynésie française\",\"French Polynesia\",\"Pōrīnetia Farāni\"],\"region\":\"Oceania\",\"subregion\":\"Polynesia\",\"population\":271800,\"latlng\":[-15.0,-140.0],\"demonym\":\"French Polynesian\",\"area\":4167.0,\"gini\":null,\"timezones\":[\"UTC-10:00\",\"UTC-09:30\",\"UTC-09:00\"],\"borders\":[],\"nativeName\":\"Polynésie française\",\"numericCode\":\"258\",\"currencies\":[{\"code\":\"XPF\",\"name\":\"CFP franc\",\"symbol\":\"Fr\"}],\"languages\":[{\"iso639_1\":\"fr\",\"iso639_2\":\"fra\",\"name\":\"French\",\"nativeName\":\"français\"}],\"translations\":{\"de\":\"Französisch-Polynesien\",\"es\":\"Polinesia Francesa\",\"fr\":\"Polynésie française\",\"ja\":\"フランス領ポリネシア\",\"it\":\"Polinesia Francese\",\"br\":\"Polinésia Francesa\",\"pt\":\"Polinésia Francesa\",\"nl\":\"Frans-Polynesië\",\"hr\":\"Francuska Polinezija\",\"fa\":\"پلی‌نزی فرانسه\"},\"flag\":\"https://restcountries.eu/data/pyf.svg\",\"regionalBlocs\":[],\"cioc\":\"\"},{\"name\":\"Poland\",\"topLevelDomain\":[\".pl\"],\"alpha2Code\":\"PL\",\"alpha3Code\":\"POL\",\"callingCodes\":[\"48\"],\"capital\":\"Warsaw\",\"altSpellings\":[\"PL\",\"Republic of Poland\",\"Rzeczpospolita Polska\"],\"region\":\"Europe\",\"subregion\":\"Eastern Europe\",\"population\":38437239,\"latlng\":[52.0,20.0],\"demonym\":\"Polish\",\"area\":312679.0,\"gini\":34.1,\"timezones\":[\"UTC+01:00\"],\"borders\":[\"BLR\",\"CZE\",\"DEU\",\"LTU\",\"RUS\",\"SVK\",\"UKR\"],\"nativeName\":\"Polska\",\"numericCode\":\"616\",\"currencies\":[{\"code\":\"PLN\",\"name\":\"Polish złoty\",\"symbol\":\"zł\"}],\"languages\":[{\"iso639_1\":\"pl\",\"iso639_2\":\"pol\",\"name\":\"Polish\",\"nativeName\":\"język polski\"}],\"translations\":{\"de\":\"Polen\",\"es\":\"Polonia\",\"fr\":\"Pologne\",\"ja\":\"ポーランド\",\"it\":\"Polonia\",\"br\":\"Polônia\",\"pt\":\"Polónia\",\"nl\":\"Polen\",\"hr\":\"Poljska\",\"fa\":\"لهستان\"},\"flag\":\"https://restcountries.eu/data/pol.svg\",\"regionalBlocs\":[{\"acronym\":\"EU\",\"name\":\"European Union\",\"otherAcronyms\":[],\"otherNames\":[]}],\"cioc\":\"POL\"}]"

//from request https://restcountries.eu/rest/v2/name/ger
let testJSON2 = "[{\"name\":\"Algeria\",\"topLevelDomain\":[\".dz\"],\"alpha2Code\":\"DZ\",\"alpha3Code\":\"DZA\",\"callingCodes\":[\"213\"],\"capital\":\"Algiers\",\"altSpellings\":[\"DZ\",\"Dzayer\",\"Algérie\"],\"region\":\"Africa\",\"subregion\":\"Northern Africa\",\"population\":40400000,\"latlng\":[28.0,3.0],\"demonym\":\"Algerian\",\"area\":2381741.0,\"gini\":35.3,\"timezones\":[\"UTC+01:00\"],\"borders\":[\"TUN\",\"LBY\",\"NER\",\"ESH\",\"MRT\",\"MLI\",\"MAR\"],\"nativeName\":\"الجزائر\",\"numericCode\":\"012\",\"currencies\":[{\"code\":\"DZD\",\"name\":\"Algerian dinar\",\"symbol\":\"د.ج\"}],\"languages\":[{\"iso639_1\":\"ar\",\"iso639_2\":\"ara\",\"name\":\"Arabic\",\"nativeName\":\"العربية\"}],\"translations\":{\"de\":\"Algerien\",\"es\":\"Argelia\",\"fr\":\"Algérie\",\"ja\":\"アルジェリア\",\"it\":\"Algeria\",\"br\":\"Argélia\",\"pt\":\"Argélia\",\"nl\":\"Algerije\",\"hr\":\"Alžir\",\"fa\":\"الجزایر\"},\"flag\":\"https://restcountries.eu/data/dza.svg\",\"regionalBlocs\":[{\"acronym\":\"AU\",\"name\":\"African Union\",\"otherAcronyms\":[],\"otherNames\":[\"الاتحاد الأفريقي\",\"Union africaine\",\"União Africana\",\"Unión Africana\",\"Umoja wa Afrika\"]},{\"acronym\":\"AL\",\"name\":\"Arab League\",\"otherAcronyms\":[],\"otherNames\":[\"جامعة الدول العربية\",\"Jāmiʻat ad-Duwal al-ʻArabīyah\",\"League of Arab States\"]}],\"cioc\":\"ALG\"},{\"name\":\"Germany\",\"topLevelDomain\":[\".de\"],\"alpha2Code\":\"DE\",\"alpha3Code\":\"DEU\",\"callingCodes\":[\"49\"],\"capital\":\"Berlin\",\"altSpellings\":[\"DE\",\"Federal Republic of Germany\",\"Bundesrepublik Deutschland\"],\"region\":\"Europe\",\"subregion\":\"Western Europe\",\"population\":81770900,\"latlng\":[51.0,9.0],\"demonym\":\"German\",\"area\":357114.0,\"gini\":28.3,\"timezones\":[\"UTC+01:00\"],\"borders\":[\"AUT\",\"BEL\",\"CZE\",\"DNK\",\"FRA\",\"LUX\",\"NLD\",\"POL\",\"CHE\"],\"nativeName\":\"Deutschland\",\"numericCode\":\"276\",\"currencies\":[{\"code\":\"EUR\",\"name\":\"Euro\",\"symbol\":\"€\"}],\"languages\":[{\"iso639_1\":\"de\",\"iso639_2\":\"deu\",\"name\":\"German\",\"nativeName\":\"Deutsch\"}],\"translations\":{\"de\":\"Deutschland\",\"es\":\"Alemania\",\"fr\":\"Allemagne\",\"ja\":\"ドイツ\",\"it\":\"Germania\",\"br\":\"Alemanha\",\"pt\":\"Alemanha\",\"nl\":\"Duitsland\",\"hr\":\"Njemačka\",\"fa\":\"آلمان\"},\"flag\":\"https://restcountries.eu/data/deu.svg\",\"regionalBlocs\":[{\"acronym\":\"EU\",\"name\":\"European Union\",\"otherAcronyms\":[],\"otherNames\":[]}],\"cioc\":\"GER\"},{\"name\":\"Niger\",\"topLevelDomain\":[\".ne\"],\"alpha2Code\":\"NE\",\"alpha3Code\":\"NER\",\"callingCodes\":[\"227\"],\"capital\":\"Niamey\",\"altSpellings\":[\"NE\",\"Nijar\",\"Republic of Niger\",\"République du Niger\"],\"region\":\"Africa\",\"subregion\":\"Western Africa\",\"population\":20715000,\"latlng\":[16.0,8.0],\"demonym\":\"Nigerien\",\"area\":1267000.0,\"gini\":34.6,\"timezones\":[\"UTC+01:00\"],\"borders\":[\"DZA\",\"BEN\",\"BFA\",\"TCD\",\"LBY\",\"MLI\",\"NGA\"],\"nativeName\":\"Niger\",\"numericCode\":\"562\",\"currencies\":[{\"code\":\"XOF\",\"name\":\"West African CFA franc\",\"symbol\":\"Fr\"}],\"languages\":[{\"iso639_1\":\"fr\",\"iso639_2\":\"fra\",\"name\":\"French\",\"nativeName\":\"français\"}],\"translations\":{\"de\":\"Niger\",\"es\":\"Níger\",\"fr\":\"Niger\",\"ja\":\"ニジェール\",\"it\":\"Niger\",\"br\":\"Níger\",\"pt\":\"Níger\",\"nl\":\"Niger\",\"hr\":\"Niger\",\"fa\":\"نیجر\"},\"flag\":\"https://restcountries.eu/data/ner.svg\",\"regionalBlocs\":[{\"acronym\":\"AU\",\"name\":\"African Union\",\"otherAcronyms\":[],\"otherNames\":[\"الاتحاد الأفريقي\",\"Union africaine\",\"União Africana\",\"Unión Africana\",\"Umoja wa Afrika\"]}],\"cioc\":\"NIG\"},{\"name\":\"Nigeria\",\"topLevelDomain\":[\".ng\"],\"alpha2Code\":\"NG\",\"alpha3Code\":\"NGA\",\"callingCodes\":[\"234\"],\"capital\":\"Abuja\",\"altSpellings\":[\"NG\",\"Nijeriya\",\"Naíjíríà\",\"Federal Republic of Nigeria\"],\"region\":\"Africa\",\"subregion\":\"Western Africa\",\"population\":186988000,\"latlng\":[10.0,8.0],\"demonym\":\"Nigerian\",\"area\":923768.0,\"gini\":48.8,\"timezones\":[\"UTC+01:00\"],\"borders\":[\"BEN\",\"CMR\",\"TCD\",\"NER\"],\"nativeName\":\"Nigeria\",\"numericCode\":\"566\",\"currencies\":[{\"code\":\"NGN\",\"name\":\"Nigerian naira\",\"symbol\":\"₦\"}],\"languages\":[{\"iso639_1\":\"en\",\"iso639_2\":\"eng\",\"name\":\"English\",\"nativeName\":\"English\"}],\"translations\":{\"de\":\"Nigeria\",\"es\":\"Nigeria\",\"fr\":\"Nigéria\",\"ja\":\"ナイジェリア\",\"it\":\"Nigeria\",\"br\":\"Nigéria\",\"pt\":\"Nigéria\",\"nl\":\"Nigeria\",\"hr\":\"Nigerija\",\"fa\":\"نیجریه\"},\"flag\":\"https://restcountries.eu/data/nga.svg\",\"regionalBlocs\":[{\"acronym\":\"AU\",\"name\":\"African Union\",\"otherAcronyms\":[],\"otherNames\":[\"الاتحاد الأفريقي\",\"Union africaine\",\"União Africana\",\"Unión Africana\",\"Umoja wa Afrika\"]}],\"cioc\":\"NGR\"},{\"name\":\"Denmark\",\"topLevelDomain\":[\".dk\"],\"alpha2Code\":\"DK\",\"alpha3Code\":\"DNK\",\"callingCodes\":[\"45\"],\"capital\":\"Copenhagen\",\"altSpellings\":[\"DK\",\"Danmark\",\"Kingdom of Denmark\",\"Kongeriget Danmark\"],\"region\":\"Europe\",\"subregion\":\"Northern Europe\",\"population\":5717014,\"latlng\":[56.0,10.0],\"demonym\":\"Danish\",\"area\":43094.0,\"gini\":24.0,\"timezones\":[\"UTC-04:00\",\"UTC-03:00\",\"UTC-01:00\",\"UTC\",\"UTC+01:00\"],\"borders\":[\"DEU\"],\"nativeName\":\"Danmark\",\"numericCode\":\"208\",\"currencies\":[{\"code\":\"DKK\",\"name\":\"Danish krone\",\"symbol\":\"kr\"}],\"languages\":[{\"iso639_1\":\"da\",\"iso639_2\":\"dan\",\"name\":\"Danish\",\"nativeName\":\"dansk\"}],\"translations\":{\"de\":\"Dänemark\",\"es\":\"Dinamarca\",\"fr\":\"Danemark\",\"ja\":\"デンマーク\",\"it\":\"Danimarca\",\"br\":\"Dinamarca\",\"pt\":\"Dinamarca\",\"nl\":\"Denemarken\",\"hr\":\"Danska\",\"fa\":\"دانمارک\"},\"flag\":\"https://restcountries.eu/data/dnk.svg\",\"regionalBlocs\":[{\"acronym\":\"EU\",\"name\":\"European Union\",\"otherAcronyms\":[],\"otherNames\":[]}],\"cioc\":\"DEN\"},{\"name\":\"Norway\",\"topLevelDomain\":[\".no\"],\"alpha2Code\":\"NO\",\"alpha3Code\":\"NOR\",\"callingCodes\":[\"47\"],\"capital\":\"Oslo\",\"altSpellings\":[\"NO\",\"Norge\",\"Noreg\",\"Kingdom of Norway\",\"Kongeriket Norge\",\"Kongeriket Noreg\"],\"region\":\"Europe\",\"subregion\":\"Northern Europe\",\"population\":5223256,\"latlng\":[62.0,10.0],\"demonym\":\"Norwegian\",\"area\":323802.0,\"gini\":25.8,\"timezones\":[\"UTC+01:00\"],\"borders\":[\"FIN\",\"SWE\",\"RUS\"],\"nativeName\":\"Norge\",\"numericCode\":\"578\",\"currencies\":[{\"code\":\"NOK\",\"name\":\"Norwegian krone\",\"symbol\":\"kr\"}],\"languages\":[{\"iso639_1\":\"no\",\"iso639_2\":\"nor\",\"name\":\"Norwegian\",\"nativeName\":\"Norsk\"},{\"iso639_1\":\"nb\",\"iso639_2\":\"nob\",\"name\":\"Norwegian Bokmål\",\"nativeName\":\"Norsk bokmål\"},{\"iso639_1\":\"nn\",\"iso639_2\":\"nno\",\"name\":\"Norwegian Nynorsk\",\"nativeName\":\"Norsk nynorsk\"}],\"translations\":{\"de\":\"Norwegen\",\"es\":\"Noruega\",\"fr\":\"Norvège\",\"ja\":\"ノルウェー\",\"it\":\"Norvegia\",\"br\":\"Noruega\",\"pt\":\"Noruega\",\"nl\":\"Noorwegen\",\"hr\":\"Norveška\",\"fa\":\"نروژ\"},\"flag\":\"https://restcountries.eu/data/nor.svg\",\"regionalBlocs\":[{\"acronym\":\"EFTA\",\"name\":\"European Free Trade Association\",\"otherAcronyms\":[],\"otherNames\":[]}],\"cioc\":\"NOR\"}]"

if let jsonData = testJSON.data(using: .utf8) 
{
    let decoder = JSONDecoder()

    do {
        let countries = try decoder.decode([Country].self, from: jsonData)
        print(printCountriesData(countries: countries))
    } catch {
        print(error.localizedDescription)
    }
}

if let jsonData2 = testJSON2.data(using: .utf8) 
{
    let decoder = JSONDecoder()

    do {
        let countries = try decoder.decode([Country].self, from: jsonData2)
        print(printCountriesData(countries: countries))
    } catch {
        print(error.localizedDescription)
    }
}
