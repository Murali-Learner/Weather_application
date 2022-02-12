import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:weather/models/currentDataModel.dart';

class WeatherApi {
  static Future<WeatherModel> apiModel(String cityName) async {
    var client = http.Client();
    String uri =
        "http://api.weatherstack.com/current?access_key=e4cbde68c2ff6a10b0ec2367b5cc6e3c&query=$cityName";

    try {
      final channaelResponse = await client.get(Uri.parse(uri));

      return weatherModelFromMap(channaelResponse.body);
    } catch (e) {
      print(e);
      return WeatherModel();
    }
  }

  // static Future forecastData(String cityName) async {
  //   var client = http.Client();
  //   String uri = "https://forecast9.p.rapidapi.com/";

  //   print(uri);
  //   Map<String, String>? headers = {
  //     'x-rapidapi-host': "forecast9.p.rapidapi.com",
  //     'x-rapidapi-key': "f9c5c7f6b0msh4356367496cb959p138a2fjsnb572a9114516"
  //   };

  //   try {
  //     // http: //api.weatherstack.com/current?access_key=260b71aedbbcfea5f33581fa18cafb2a&query=Mountain Viewhttp://api.weatherstack.com/current?access_key=260b71aedbbcfea5f33581fa18cafb2a&query=Mountain View
  //     final forecastResponse =
  //         await client.get(Uri.parse(uri), headers: headers);
  //     print(forecastResponse.body);
  //     return (forecastResponse.body);
  //   } catch (e) {
  //     print(e);
  //     return WeatherModel();
  //   }
  // }
}
