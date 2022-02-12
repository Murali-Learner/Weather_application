import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:geocoder/geocoder.dart';
import 'package:weather/models/currentDataModel.dart';
import 'package:weather/pages/contactPage.dart';
import 'package:weather/pages/loginPage.dart';

import 'package:weather/services/getLocatoin.dart';
import 'package:weather/services/api.dart';
import 'package:weather/widgets/detailWeather.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<WeatherModel> getCurrentWeatherDetails() async {
    Address city = await Getlocation.getlocation();

    if (city != null) {
      // print();
      final weatherModel =
          await WeatherApi.apiModel(city.locality.trim().toLowerCase());

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
                child: FutureBuilder<WeatherModel>(
                  future: getCurrentWeatherDetails(),
                  // initialData: InitialData,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      // print("city:n=${snapshot.data!.current}");
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
                                    text: snapshot.data.location.name,
                                    style: const TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            ", ${snapshot.data.location.country}",
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
                                  width: _height * 0.07,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    FirebaseAuth auth = FirebaseAuth.instance;
                                    await auth.signOut();
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const Login();
                                      },
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                )
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
                            snapshot.data.location.localtime,
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
                                "Temp: ${snapshot.data.current.temperature.toString()} C",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: _height * 0.03,
                              ),
                              Image.network(
                                snapshot.data.current.weatherIcons.first,
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
                                content: "Feels like\n",
                                text: snapshot.data.location.utcOffset,
                              ),
                              Content(
                                content: "Humidity\n",
                                text: snapshot.data.current.humidity.toString(),
                              ),
                              Content(
                                content: "Description\n",
                                text: snapshot.data.current.weatherDescriptions
                                    .first.characters
                                    .toString(),
                              ),
                              Content(
                                content: "Wind Speed \n \t  ",
                                text:
                                    snapshot.data.current.windSpeed.toString(),
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    shadowColor: Colors.white,
                    primary: Colors.grey.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ContactPage();
                      },
                    ));
                  },
                  child: const Text(
                    "Add Contacts",
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
