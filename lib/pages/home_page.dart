import 'package:connectfirebase/pages/b.dart';
import 'package:connectfirebase/pages/onoff.dart';
import 'package:flutter/material.dart';
import 'package:connectfirebase/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';


import 'package:connectfirebase/models/todo.dart';
import 'dart:async';
import 'package:connectfirebase/pages/show_info.dart';
import 'package:connectfirebase/pages/detail.dart';
import 'package:connectfirebase/pages/read_cloudstoge.dart';

import 'package:connectfirebase/pages/drawer_main.dart';
import 'package:connectfirebase/pages/Dashboard.dart';


import 'package:connectfirebase/pages/SwitchWidget.dart';

import 'package:connectfirebase/pages/onoff.dart';

import 'package:connectfirebase/pages/camera.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

   Widget myWidget = Dashboard();

  // Method
  Widget myDivider() {
    return Divider(
      height: 5.0,
      color: Colors.blue[800],
    );
  }

  //bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
  
  }
      
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

Widget menuDashboard() {
    return ListTile(
      leading: Icon(
        Icons.account_box,
        size: 36.0,
        color: Colors.orange,
      ),
      title: Text(
        'Realtime Value',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = Dashboard();
          Navigator.of(context).pop();
        });
      },
    );
  }

 Widget menuDetail() {
    return ListTile(
      leading: Icon(
        Icons.beach_access,
        size: 36.0,
        color: Colors.red[500],
      ),
      title: Text(
        'Detail test',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = Detail();
          Navigator.of(context).pop();
        });
      },
    );
  }

  

 Widget menureadcloud() {
    return ListTile(
      leading: Icon(
        Icons.access_alarm,
        size: 36.0,
        color: Colors.green[500],
      ),
      title: Text(
        'Read cloudstoge',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = ShowProduct();
          Navigator.of(context).pop();
        });
      },
    );
  }

 Widget menuread() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.pink[500],
      ),
      title: Text(
        'Readrealtim',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          // myWidget = FirebaseDemoScreen();
          Navigator.of(context).pop();
        });
      },
    );
  }

   Widget menua1() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.pink[500],
      ),
      title: Text(
        'value box',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = Dashboard();
          Navigator.of(context).pop();
        });
      },
    );
  }

 Widget menub() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.pink[500],
      ),
      title: Text(
        'add data',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = Testpage();
          Navigator.of(context).pop();
        });
      },
    );
  }
  
  Widget menub1() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.pink[500],
      ),
      title: Text(
        'switch',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = SwitchWidget();
          Navigator.of(context).pop();
        });
      },
    );
  }
   
 
  
  Widget menuonoff() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.pink[500],
      ),
      title: Text(
        'onoff1',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = OnOff();
          Navigator.of(context).pop();
        });
      },
    );
  }
  
  Widget menutime() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.pink[500],
      ),
      title: Text(
        'DateTimeP',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = Setcontrol();
          Navigator.of(context).pop();
        });
      },
    );
  }
   Widget menucamera() {
    return ListTile(
      leading: Icon(
        Icons.camera_alt,
        size: 36.0,
        color: Colors.pink[500],
      ),
      title: Text(
        'Camera',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = Camera();
          Navigator.of(context).pop();
        });
      },
    );
  }
  
  
    Widget headMenu() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, Colors.blue[100]],
          radius: 1.5,
          center: Alignment.center,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 75.0,
            height: 75.0,
            child: Image.asset('images/logo1.png'),
          ),
          Text(
            'smart app',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
            ),
          ),
        //  Text('Login by $nameString')
        ],
      ),
    );
  }



  
  Widget showDrawerMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          headMenu(),
          //menuShowProduct(),
          //myDivider(),
          //menuShowMap(),
          //myDivider(),
          menuDashboard(),
          myDivider(),

          menuDetail(),
          myDivider(),

          menureadcloud(),
          myDivider(),

          menuread(),
          myDivider(),

          
          menua1(),
          myDivider(),

          menub(),
          myDivider(),
          
          menub1(),
          myDivider(),

          menutime(),
          myDivider(),
           
          menuonoff(),
          myDivider(),

          menucamera(),
          myDivider(),
          //menuQRcode(),
          //myDivider(),
          //signOutAnExit(),
        ],
      ),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Smart App'),
          actions: <Widget>[
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: signOut)
          ],
        ),
      body: myWidget,
      drawer: showDrawerMenu(),

        
        );
  }
}





