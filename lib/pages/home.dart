import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';

import 'package:weather/models/apiModel.dart';
import 'package:weather/services/getLocatoin.dart';
import 'package:weather/services/api.dart';

class Home extends StatelessWidget {
  Future<WeatherModel> getCurrentWeatherDetails() async {
    Address city = await Getlocation.getlocation();

    if (city != null) {
      final weatherModel = await WeatherApi.apiModel(city.locality);

      return weatherModel;
    } else {
      return WeatherModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: _height,
          width: _width,
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage("images/main.jpeg"),
                fit: BoxFit.fill,
                opacity: 0.3),
          ),
          // margin: EdgeInsets.all(_width * 0.05),
          child: Column(
            children: [
              Container(
                height: _height * 0.7,
                width: _width,
                // color: Colors.amber.shade400,
                child: FutureBuilder<WeatherModel>(
                  future: getCurrentWeatherDetails(),
                  // initialData: InitialData,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      // print();
                      return Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: _height * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: snapshot.data!.location.name,
                                    style: const TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            ", ${snapshot.data!.location.country}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: _height * 0.007,
                                ),
                                Center(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.person,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.006,
                          ),
                          const Center(
                            child: Text(
                              "Today",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.006,
                          ),
                          Text(
                            snapshot.data!.location.localtime,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.054,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Temp: ${snapshot.data!.current.temperature.toString()} C",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: _height * 0.03,
                              ),
                              Image.network(
                                snapshot.data!.current.weatherIcons.first,
                                height: _width * 0.08,
                                width: _width * 0.08,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: _height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Content(
                                text:
                                    "feels like\n${snapshot.data!.location.utcOffset}",
                              ),
                              Content(
                                text:
                                    "humidity\n${snapshot.data!.current.humidity}",
                              ),
                              Content(
                                text:
                                    "description\n${snapshot.data!.current.weatherDescriptions.first.characters}",
                              ),
                              Content(
                                text:
                                    "wind_speed\n${snapshot.data!.current.windSpeed}",
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  String text;
  Content({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.6),
      ),
    );
  }
}
