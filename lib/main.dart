import 'package:flutter/material.dart';
import 'package:list_with_widgets/duck_page.dart';
import 'package:list_with_widgets/gesture_detector_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
        backgroundColor: Colors.teal[400],
      ),
      body: Column(
        children: <Widget> [
          Row(
            children: <Widget> [
              Text('Stateless Duck'),
              RaisedButton(
                child: Text('Go to page'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StatelessDuck()),
                  );
                },
              ),
            ],

          ),
          Row(
            children: <Widget> [
              Text('Gesture detector'),
              RaisedButton(
                child: Text('Go to page'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyStatefulWidget()),
                  );
                },
              ),
            ],

          )
      ]
      ),
    );
  }
}

Widget buildMyWidget(var name, double height){
  return Padding(
      padding: EdgeInsets.all(2),
      child: Container(
        height: height,
        width: 200,
        color: Colors.red,
        child: Text(name),
      )
  );
}

