import 'package:flutter/material.dart';


class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

void data() {
  print(new DateTime.now().millisecondsSinceEpoch);
}
  @override
  Widget build(BuildContext context) {
        data();
    return Container(
      child: Text(''),
      
    );
  }
}
