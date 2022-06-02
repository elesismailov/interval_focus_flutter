import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TimerHomePage(),
    primarySwatch: Color.black,
    ));
}


class TimerHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text('hello app'),
          ),
      );
  }

}