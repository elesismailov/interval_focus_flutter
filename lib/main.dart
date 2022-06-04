import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TimerHomePage(),
    ));
}

class TimerHomePage extends StatefulWidget {
	
	@override
	State<StatefulWidget> createState() {
		return _TimerHomePage();
	}

}

class _TimerHomePage extends State<TimerHomePage> {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.black,
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
					Text('Focus', style: stl),
					Text('00:00', style: stl),
					Text('Session Number: ', style: stl),
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
						ElevatedButton(onPressed: () {}, child: Text('Start')),
						ElevatedButton(onPressed: () {}, child: Text('Pause')),]
					),],
				),
			),
		);
	}

}


TextStyle stl = const TextStyle(color: Colors.white);
