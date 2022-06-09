import 'dart:async';
import 'package:flutter/material.dart';

import './notifications.dart';

class TimerWidget extends StatefulWidget {

	@override
	State<StatefulWidget> createState() {
		return _TimerWidgetState();
	}

}

class _TimerWidgetState extends State<TimerWidget> {

	final InitialTimerState _timer = InitialTimerState();
  bool _isFirstLoad = true;

  void start() {

    if ( !_timer.isOn ) {
      int startTime = DateTime.now().millisecondsSinceEpoch;
      int sessionLength = _timer.interval[_timer.sessionNumber];
      int endTime = startTime + ((_timer.leftTimeWhenPaused != 0) ? _timer.leftTimeWhenPaused : sessionLength);

      _timer.startTime = startTime;
      _timer.sessionLength = sessionLength;
      _timer.endTime = endTime;
      _timer.isOn = true;
      _isFirstLoad = false;

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

  void mainTimer() async {

    if ( _timer.isOn ) {
      int now = DateTime.now().millisecondsSinceEpoch;

      if ( now - 500 <= _timer.endTime ) {
        int leftTime = _timer.endTime - now;

        setState(() {
          _timer.userTime = leftTime;
          });

        Timer(const Duration(milliseconds: 200), mainTimer);
      } else {

        resetTimer();

        // notificationsApi.showNotification(
        notificationsApi.showNotificationWithSound(
          'Interval Focus',
          (_timer.mode == 0) ? 'It is time to take a break!' : 'Time to get to work!',
          null,
          );

        _timer.nextSession();

        start();

      }
    }
  }

  void stop() {
    // TODO confirmation dialogue
    if ( !_timer.isOn ) {
      resetTimer();
      setState(() {
        _timer.sessionNumber = 0;
        _timer.userTime = 0;
        _isFirstLoad = true;
        });
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
    // TODO extract userTime to _getTextTime()
		String _min = ('0' + ((
      (_timer.userTime == 0) 
        ? _timer.interval[_timer.sessionNumber] 
        : _timer.userTime
      )/1000~/60).toString());
		String _sec = ('0' + ((
      (_timer.userTime == 0) 
        ? _timer.interval[_timer.sessionNumber] 
        : _timer.userTime
      )~/1000%60).toString());
		return Scaffold(
			backgroundColor: Colors.black,
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						/* ElevatedButton(onPressed: () { */
						/* 	// notificationsApi.showNotification( */
						/* 	notificationsApi.showNotificationWithSound( */
						/* 		'Interval Focus', */
						/* 		(_timer.mode == 0) ? 'It is time to take a break!' : 'Time to get to work!', */
						/* 		null, */
						/* 		); */
						/* }, child: Text('n')), */
  					Text((_timer.mode == 0) ? 'Focus' : 'Break', style: const TextStyle(color: Colors.grey, fontSize: 14.0)),
  					Container(
  						margin: const EdgeInsets.symmetric(vertical: 10.0),
  						child: Text('${_min.substring(_min.length-2)}:${_sec.substring(_sec.length-2)}', style: const TextStyle(color: Colors.white, fontSize: 26.0))),
  					Text('Session Number: ' + _timer.sessionNumber.toString(), style: const TextStyle(color: Colors.grey, fontSize: 14.0)),
  					Container(
  						margin: const EdgeInsets.symmetric(vertical: 0),
  						child: Wrap(
  							spacing: 0,
  							children: _getButtons(),
  						),)
  					],
				),
			),
		);
	}

  List<Widget> _getButtons() {
    Widget startBt = IconButton(onPressed: start, iconSize: 50, icon: const Icon(Icons.play_circle_rounded, color: Colors.blue));
    Widget pauseBt = IconButton(onPressed: pause, iconSize: 50, icon: const Icon(Icons.pause_circle_rounded, color: Colors.blue));
    Widget stopBt = IconButton(onPressed: stop, iconSize: 50, icon: const Icon(Icons.stop_circle_rounded, color: Colors.blue));

    if (!_timer.isOn && _isFirstLoad) {
      return [ startBt ];
    } else if (!_timer.isOn) {
      return [ startBt, stopBt ];
    }
    return [ pauseBt ];
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
  // List<int> interval = [2400000, 600000, 2400000, 600000];
  List<int> interval = [9000, 6000, 9000, 6000];
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
