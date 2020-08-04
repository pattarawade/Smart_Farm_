import 'dart:async';
import 'dart:ffi';
import 'package:condition/condition.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:connectfirebase/models/realtime.dart';

import 'CircleProgress.dart';
// import 'main.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final databaseReference = FirebaseDatabase.instance.reference();
  String heatIndexText;
  Timer _timer;
  bool a;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AnimationController progressController;
  Animation<double> tempAnimation;
  Animation<double> humidityAnimation;
  Animation<double> soilAnimation;
  Animation<double> waterAnimation;

  _DashboardInit(double temp, double humid, double soil, double water) {
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000)); //5s

    tempAnimation =
        Tween<double>(begin: -50, end: temp).animate(progressController)
          ..addListener(() {
            setState(() {
              print(tempAnimation.value);
            });
            return tempAnimation.value;
          });

    humidityAnimation =
        Tween<double>(begin: 0, end: humid).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    soilAnimation =
        Tween<double>(begin: -50, end: soil).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    waterAnimation =
        Tween<double>(begin: 0, end: water).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    progressController.forward();
  }

  @override
  void initState() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
      print("onDidReceiveLocalNotification called.");
    });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    // a = true;
    super.initState();
    noti();

    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {});
    });

    //  setState(() {});
    databaseReference
        .reference()
        .child('data')
        .once()
        .then((DataSnapshot snapshot) {
      double temp = snapshot.value['Temperature'] + 0.0;
      double humidity = snapshot.value['Humidity'] + 0.0;
      double soil = snapshot.value['Soilmoisture'] + 0.0;
      double water = snapshot.value['waterlevel'] + 0.0;

      isLoading = true;
      _DashboardInit(temp, humidity, soil, water);
    });
  }

  Future<void> scheduleNotification() async {
    var scheduleNotificationDateTime = DateTime.now();
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 1',
      'CHANNEL_NAME 1',
      "CHANNEL_DESCRIPTION 1",
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails(
      sound: 'my_sound.aiff',
    );
    var platformChannelSpecifics = NotificationDetails(
      androidChannelSpecifics,
      iosChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.schedule(
      0,
      '<b>Water Level<b>',
      'Low Water',
      scheduleNotificationDateTime,
      platformChannelSpecifics,
    );
    
  }
  Future<void> noti()async{
     var a = Text('${waterAnimation.value.toInt()}');
      if (a == 40) {
        scheduleNotification();
      }
  }

  @override
  void dispose() {
    // databaseReference.dispose();
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return test();
  }

  @override
  Widget test() {
    return Scaffold(
      body: SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomPaint(
                    foregroundPainter:
                        CircleProgress(tempAnimation.value, true),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Temperature'),
                            Text(
                              '${tempAnimation.value.toInt()}',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '°C',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomPaint(
                    foregroundPainter:
                        CircleProgress(humidityAnimation.value, false),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Humidity'),
                            Text(
                              '${humidityAnimation.value.toInt()}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '%',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomPaint(
                    foregroundPainter:
                        CircleProgress(soilAnimation.value, true),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Soilmoisture'),
                            Text(
                              '${soilAnimation.value.toInt()}',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '°C',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomPaint(
                    foregroundPainter:
                        CircleProgress(waterAnimation.value, true),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Water Level'),
                            Text(
                              '${waterAnimation.value.toInt()}',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '%',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(),
                ],
              )
            : Text(
                'Loading...',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
      )),
    );
  }

  handleLoginOutPopup() {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Login Out",
      desc: "Do you want to login out now?",
      buttons: [
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.teal,
        ),
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: handleSignOut,
          color: Colors.teal,
        )
      ],
    ).show();
  }

  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();

    this.setState(() {
      isLoading = false;
    });

    // Navigator.of(context).pushAndRemoveUntil(
    // MaterialPageRoute(builder: (context) => MyApp()),
    // (Route<dynamic> route) => false);
  }
}
