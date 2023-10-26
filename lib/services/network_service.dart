
import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {

  Future<dynamic> getCountry(String countryName) async {
    String url = "https://restcountries.com/v3.1/name/$countryName";

    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      final countryData = jsonDecode(response.body) as List<dynamic>;
      return countryData;
    } else {
      return Future.error("Cannot find the country.");
    }

  }

   Future<dynamic> getPublicHolidays(String countryCode, String year) async {
    String url = "https://date.nager.at/api/v3/PublicHolidays/$year/$countryCode";
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      final publicHolidays = jsonDecode(response.body) as List<dynamic>;
      return publicHolidays;
    } else {
      return Future.error("Cannot find the public holidays.");
    }
    

  }

  Future<Map<String,String>> getBorderFlags(List borderCountryCodes) async {
    Map<String,String> flagUrls = {};
    for(String code in borderCountryCodes) {
      String url = "https://restcountries.com/v3.1/alpha/$code?fields=flags";
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final flagUrl = data["flags"]["png"];
        flagUrls[code] = flagUrl;
      } else {
        flagUrls[code] = "";
    }

    }

    return flagUrls;
    
  }
}