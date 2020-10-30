import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  double sideLength = 50;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
        backgroundColor: Colors.teal[400],
      ),
      body: Center(
        child: AnimatedContainer(
            height: sideLength,
            width: sideLength,
            duration: Duration(seconds: 2),
            curve: Curves.easeIn,
            child: Material(
              color: Colors.yellow,
              child: InkWell(
                onTap: () {
                  setState(() {
                    sideLength == 50 ? sideLength = 100 : sideLength = 50;
                  });
                },
              ),
            ),
          ),
      ),
    );
  }
}
