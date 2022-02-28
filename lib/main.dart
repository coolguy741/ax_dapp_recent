import 'package:ax_dapp/pages/LandingPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Returns anything!
    return MaterialApp(
      title: "AthleteX",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      theme: ThemeData(
          canvasColor: Colors.transparent,
          brightness: Brightness.dark,
          primaryColor: Colors.yellow[700],
          colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark)
              .copyWith(secondary: Colors.black)),
      home: LandingPage(),
      // home: V1App(),
      // home: HomePage()
    );
  }
}
