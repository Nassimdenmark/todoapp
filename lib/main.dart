import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:todoapp/screens/welcome_page.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text(
        'Todo',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
      ),
      seconds: 5,
      navigateAfterSeconds: AfterSplash(),
      image: new Image.asset(
        'assets/logo.png',
        height: 100,
        width: 100,
      ),
      backgroundColor: Color.fromRGBO(231, 129, 109, 1.0),
      photoSize: 150.0,
      onClick: () {},
      loaderColor: Colors.white,
      loadingText: Text(
        '   Todo. Just for you.\n\n\n\n2020 Nassim Ghonem',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
