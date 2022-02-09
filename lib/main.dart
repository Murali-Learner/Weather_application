import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/apiModel.dart';
import 'package:weather/services/getLocatoin.dart';
import 'package:weather/pages/home.dart';
import 'package:weather/pages/loginPage.dart';
import 'package:weather/services/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // FutureProvider<WeatherModel>(
        //   create: (context) {
        //     return ApiData.apiModel("");
        //   },
        //   initialData: WeatherModel(),
        // ),
        ChangeNotifierProvider<Getlocation>(
          create: (context) {
            return Getlocation();
            // return Getlocation.getLocation();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Home(),
      ),
    );
  }
}
