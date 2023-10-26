import "package:intl/intl.dart";

class Country {
  final String name;
  final String officialName;
  final String capital;
  final String cca2;
  final String cca3;
  final Map<String,dynamic> currencies;
  final List borders;
  Map<String,String>? borderFlags;
  final String flagUrl;
  final Map<String,double> latlng;
  final List<Holiday> holidays;


  Country({
    required this.name, 
    required this.officialName,
    required this.capital,
    required this.cca2,
    required this.cca3,
    required this.currencies,
    required this.borders,
    required this.flagUrl,
    required this.latlng,
    required this.holidays,
    });

    factory Country.fromjson(List countryJson, List holidayJson) {

      return Country(
        name: countryJson[0]["name"]["common"], 
        officialName: countryJson[0]["name"]["official"], 
        capital: countryJson[0]["capital"][0], 
        cca2: countryJson[0]["cca2"], 
        cca3: countryJson[0]["cca3"],  
        currencies: countryJson[0]["currencies"], 
        borders: countryJson[0]["borders"],
        flagUrl: countryJson[0]["flags"]["png"], 
        latlng: {"lat": countryJson[0]["latlng"][0],"lng": countryJson[0]["latlng"][1] },
        holidays: holidayJson.map((day) => Holiday.fromjson(day)).toList()
      );

    }
}

class Holiday {
 final DateTime date;
 final String localName;
 final String name;

  Holiday({required this.date, required this.localName, required this.name});

  factory Holiday.fromjson(Map<String,dynamic> holidayJson) {
    var date = holidayJson["date"] as String;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime dateTime = dateFormat.parse(date);
    return Holiday(
      date: dateTime, 
      localName: holidayJson["localName"]!, 
      name: holidayJson["name"]!
      );
  }

}