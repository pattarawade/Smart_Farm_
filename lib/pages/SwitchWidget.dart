
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

 class SwitchWidget extends StatefulWidget {
    @override
    SwitchWidgetClass createState() => new SwitchWidgetClass();
  }
  class SwitchWidgetClass extends State {

    final databaseReference = FirebaseDatabase.instance.reference();
    int off=0;
    int on=1;
    
    bool switchControl = false;
    var textHolder = 'Switch is OFF light';

    bool switchControl2 = false;
    var textHolder2 = 'Switch is OFF fan';

    bool switchControl3 = false;
    var textHolder3 = 'Switch is OFF pump';


 void getData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void createlight(){
    databaseReference.child("data/control_light_update").set({
      // 'title': 'Mastering EJB',
      'light':off  //off
    });   
  }

  void updatelight(){
    databaseReference.child('data/control_light_update').update({
      'light':on  //on 1
    });

  }
   void create_fan(){

    databaseReference.child("data/control_fan_update").set({
      // 'title': 'Mastering EJB',
      'fan':off  //off
    });   
  }
  void update_fan(){
    databaseReference.child('data/control_fan_update').update({
      'fan':on  //on 1
    });

  }
  void createpump(){
    databaseReference.child("data/control_pump_update").set({
      // 'title': 'Mastering EJB',
      'pump':off  //off
    });   
  }
  void updatepump(){
    databaseReference.child('data/control_pump_update').update({
      'pump':on  //on 1
    });

  }

  void toggleSwitch(bool value) {
      if(switchControl == false)
      {
        setState(() {
           updatelight();
         ;
          switchControl = true;
          textHolder = 'Switch is ON light';
        });
        print('Switch is ON light');
        // Put your code here which you want to execute on Switch ON event.
      }
      else
      {
        setState(() {
          createlight();
          switchControl = false;
           textHolder = 'Switch is OFF light';
        });
        print('Switch is OFF light');
        // Put your code here which you want to execute on Switch OFF event.
      }
  }


  void toggleSwitch2(bool value) {
      if(switchControl2 == false)
      {
        setState(() {
          update_fan();
          switchControl2 = true;
          textHolder2 = 'Switch is ON fan';
        });
        print('Switch is ON fan');
        // Put your code here which you want to execute on Switch ON event.
      }
      else
      {
        setState(() {
          create_fan();
          switchControl2 = false;
           textHolder2 = 'Switch is OFF fan';
        });
        print('Switch is OFF fan');
        // Put your code here which you want to execute on Switch OFF event.
      }
  }


  void toggleSwitch3(bool value) {
      if(switchControl3 == false)
      {
        setState(() {
          updatepump();
          switchControl3 = true;
          textHolder3 = 'Switch is ON pump';
        });
        print('Switch is ON pump');
        // Put your code here which you want to execute on Switch ON event.
      }
      else
      {
        setState(() {
          createpump();
          switchControl3 = false;
           textHolder3 = 'Switch is OFF pump';
        });
        print('Switch is OFF pump');
        // Put your code here which you want to execute on Switch OFF event.
      }
  }

    void _onChanged1(){
        // setState(() => _value2 = value);
      print('1');
    }
    void _onChanged2(){
        // setState(() => _value2 = value);
      print('2222222');
    }

    var orange = Color(0xFFfc9f6a);
    var pink = Color(0xFFee528c);
    var blue = Color(0xFF8bccd6);
    var darkBlue = Color(0xFF60a0d7);
    var valueBlue = Color(0xFF5fa0d6);
  
    @override
    Widget build(BuildContext context) {
       getData();
      return new Scaffold(

      // appBar: new AppBar(
      //   title: new Text('Name here'),
      // ),

      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
     
              
      body: new Container(
        padding: new EdgeInsets.all(50.0),
        child: new Center(
          child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // new Switch(value: _value1, onChanged: _onChanged3),
              Container(
                 child: Container( width: 350,height: 100,
                 child: Card(
                  color: Colors.teal[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),  
                  ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       new SwitchListTile(
                          onChanged: toggleSwitch,
                          value: switchControl,
                          title : new Text('Light', style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold, color: Colors.black,fontFamily: 'YanoneKaffeesatz-VariableFont_wght',)),
                          activeColor: Colors.teal,
                          activeTrackColor: Colors.teal[300],
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                          secondary: const Icon(Icons.lightbulb_outline,color: Colors.yellow,size: 30.0,),
                        ),
                      ],
                    ),
                  ),
                 ), 
              ),

              Container(
                 child: Container( width: 350,height: 100,
                 child: Card(
                  color: Colors.teal[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),  
                  ), 
                    child: new Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       new SwitchListTile(
                          onChanged: toggleSwitch2,
                          value: switchControl2,
                          title : new Text('Fan', style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'YanoneKaffeesatz-VariableFont_wght',)),
                          activeColor: Colors.teal,
                          activeTrackColor: Colors.teal[300],
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                          secondary: const Icon(Icons.toys_outlined,color: Colors.brown,size: 30.0,),
                          ),
                       ],
                      ),
                    ),
                 ), 
              ),

              Container(
                 child: Container( width: 350,height: 100,
                 child: Card(
                  color: Colors.teal[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),  
                  ),
                 
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     new SwitchListTile(
                        onChanged: toggleSwitch3,
                        value: switchControl3,
                        title : new Text('Waterpump', style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold, color: Colors.black,fontFamily:'YanoneKaffeesatz-VariableFont_wght',)),
                        activeColor: Colors.teal,
                        activeTrackColor: Colors.teal[300],
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                        secondary: const Icon(Icons.invert_colors,color: Colors.blue,size: 30.0,),
                        ),
                       ],
                      ),
                    ), 
                 ), 
              ),
            
              
              // new Switch(value: _value1, onChanged: _onChanged1),

              // new SwitchListTile( value: _value2, onChanged: _onChanged2,
              //     title: new Text('Hello World', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              // )
            
            
            ],
          ),
        ),
      ),
    );
      
  }
}








