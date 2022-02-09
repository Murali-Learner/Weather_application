import 'package:http/http.dart' as http;
import 'package:weather/models/apiModel.dart';

class WeatherApi {
  static Future<WeatherModel> apiModel(String cityName) async {
    var client = http.Client();
    String uri =
        "http://api.weatherstack.com/current?access_key=260b71aedbbcfea5f33581fa18cafb2a&query=$cityName";
    print(uri);
    try {
      // http: //api.weatherstack.com/current?access_key=260b71aedbbcfea5f33581fa18cafb2a&query=Mountain Viewhttp://api.weatherstack.com/current?access_key=260b71aedbbcfea5f33581fa18cafb2a&query=Mountain View
      final channaelResponse = await client.get(Uri.parse(uri));

      return weatherModelFromMap(channaelResponse.body);
    } catch (e) {
      print(e);
      return WeatherModel();
    }
  }

  static Future forecastData(String cityName) async {
    var client = http.Client();
    String uri = "https://forecast9.p.rapidapi.com/";

    print(uri);
    Map<String, String>? headers = {
      'x-rapidapi-host': "forecast9.p.rapidapi.com",
      'x-rapidapi-key': "f9c5c7f6b0msh4356367496cb959p138a2fjsnb572a9114516"
    };

    try {
      // http: //api.weatherstack.com/current?access_key=260b71aedbbcfea5f33581fa18cafb2a&query=Mountain Viewhttp://api.weatherstack.com/current?access_key=260b71aedbbcfea5f33581fa18cafb2a&query=Mountain View
      final forecastResponse =
          await client.get(Uri.parse(uri), headers: headers);
      print(forecastResponse);
      return (forecastResponse.body);
    } catch (e) {
      print(e);
      return WeatherModel();
    }
  }
}
