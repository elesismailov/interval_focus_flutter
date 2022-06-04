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

	InitialTimerState _timer = new InitialTimerState();
  void start() {

    if ( !_timer.isOn ) {
      int startTime = DateTime.now().millisecondsSinceEpoch;
      int sessionLength = _timer.interval[_timer.sessionNumber];
      int endTime = startTime + ((_timer.leftTimeWhenPaused != 0) ? _timer.leftTimeWhenPaused : sessionLength);

      _timer.startTime = startTime;
      _timer.sessionLength = sessionLength;
      _timer.endTime = endTime;
      _timer.isOn = true;

      mainTimer();
    }
  }

  void pause() {
    if ( _timer.isOn ) {
      int now = DateTime.now().millisecondsSinceEpoch;
      int leftTimeWhenPaused = _timer.endTime - now;
      setState(() {
          _timer.leftTimeWhenPaused = leftTimeWhenPaused;
          _timer.isOn = false;
        });
    }
  }

  void mainTimer() {

    if ( _timer.isOn ) {
      int now = DateTime.now().millisecondsSinceEpoch;

      if ( now - 500 <= _timer.endTime ) {
        int leftTime = _timer.endTime - now;

        setState(() {
          _timer.userTime = leftTime;
          });

        Timer(const Duration(milliseconds: 500), mainTimer);
      } else {

        resetTimer();

        _timer.nextSession();

        start();

      }
    }

  }

  void resetTimer() {
      _timer.isOn = false;
      _timer.leftTimeWhenPaused = 0;
      _timer.startTime = 0;
      _timer.endTime = 0; 

  }

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


class InitialTimerState {
  int mode = 0; // 0 - focus, 1 - break
  int sessionLength = 0;
  int userTime = 0;
  bool isOn = false;
  int startTime = 0;
  int endTime = 0;
  int leftTimeWhenPaused = 0;
  int sessionNumber = 0;
  List<int> interval = [9000, 5000, 9000, 5000];
  // List<int> interval = [];

  void nextSession() { 
    if ( interval.length-1 == sessionNumber ) {
      sessionNumber = 0;
    } else {
      sessionNumber++;
    }
    switchMode();
  }

  void switchMode() {
    if ( sessionNumber%2 == 0 ) {
      mode = 0;
    } else {
      mode = 1;
    }
  }
}

TextStyle stl = const TextStyle(color: Colors.white);
