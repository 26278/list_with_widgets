import 'package:flutter/material.dart';

class StatelessDuck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
        backgroundColor: Colors.teal[400],
      ),
      body: Column(
          children: <Widget> [
            Center(
              child: Image(
                image: AssetImage("images/duck.jpeg"),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go back'),
              ),
            ),
          ]
      ),
    );
  }
}
