import 'package:flutter/material.dart';
import 'package:connectfirebase/services/authentication.dart';
import 'package:connectfirebase/pages/root_page.dart';
import 'package:flutter/services.dart';

//import 'package:connectfirebase/pages/manu.dart';
//import 'login_signup_page.dart';
void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return new MaterialApp(
        title: 'login demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
          
          cursorColor: Colors.orange,
          accentColor: Colors.red,
         

          fontFamily: 'YanoneKaffeesatz'
        ),
        home: new RootPage(auth: new Auth()));
  }
}