import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  Future<Map?> CovidApi({required String Country}) async {
    String api =
        "https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/total?country=${Country}";
    Uri myUrl = Uri.parse(api);
    http.Response res = await http.get(
      myUrl,
      headers: {
        "X-RapidAPI-Key": "791ef41f82mshe13d5276cb7121cp1b8e6cjsnb12fdff84b39",
        "X-RapidAPI-Host": "covid-19-coronavirus-statistics.p.rapidapi.com"
      },
    );
    if (res.statusCode == 200) {
      Map data = jsonDecode(res.body);
      return data;
    }
    return null;
  }

  Future<Map?> CovidAllApi() async {
    String api = "https://covid-193.p.rapidapi.com/countries";
    Uri myUrl = Uri.parse(api);
    http.Response res = await http.get(
      myUrl,
      headers: {
        "X-RapidAPI-Key": "791ef41f82mshe13d5276cb7121cp1b8e6cjsnb12fdff84b39",
        "X-RapidAPI-Host": "covid-193.p.rapidapi.com"
      },
    );
    if (res.statusCode == 200) {
      Map data = jsonDecode(res.body);
      return data;
    }
    return null;
  }
}
