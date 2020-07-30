import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// Added .dart files
import 'package:connectfirebase/screens/home.dart';
import 'package:connectfirebase/screens/item.dart';

class Setcontrol extends StatelessWidget {

  Widget build(BuildContext context) {
  startabc();
    var routes = <String, WidgetBuilder> {
      '/item' : (BuildContext context) => new ItemScreen(),
    };

    return new MaterialApp(
      title: 'Flutter Firebase CRUD app',
      home: new ItemScreen(),
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      routes: routes,
    );
  }
void startabc() {
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  print("Started...");
 
} 




}