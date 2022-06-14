import 'dart:async';
import 'package:flutter/material.dart';
import 'package:interval_focus/storage.dart';

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
      int sessionLength = _timer.interval.sessions[_timer.sessionNumber].len;
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
				_timer.mode = 0;
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
		String _min = ('0${((
      (_timer.userTime == 0) 
        ? _timer.interval.sessions[_timer.sessionNumber].len 
        : _timer.userTime
      )/1000~/60)}');
		String _sec = ('0${((
      (_timer.userTime == 0) 
        ? _timer.interval.sessions[_timer.sessionNumber].len 
        : _timer.userTime
      )~/1000%60)}');
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
  					Text((_timer.mode == 0) ? 'Focus' : 'Break', style: const TextStyle(color: Colors.grey, fontSize: 18.0)),
  					Container(
  						margin: const EdgeInsets.symmetric(vertical: 10.0),
  						child: Text('${_min.substring(_min.length-2)}:${_sec.substring(_sec.length-2)}', style: const TextStyle(color: Colors.white, fontSize: 50.0))),
  					/* Text('Session Number: ' + _timer.sessionNumber.toString(), style: const TextStyle(color: Colors.grey, fontSize: 14.0)), */
						sessionIndicator(),
  					Container(
  						margin: const EdgeInsets.symmetric(vertical: 5),
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
    Widget startBt = IconButton(onPressed: start, iconSize: 60, icon: const Icon(Icons.play_circle_rounded, color: Colors.blue));
    Widget pauseBt = IconButton(onPressed: pause, iconSize: 60, icon: const Icon(Icons.pause_circle_rounded, color: Colors.blue));
    Widget stopBt = IconButton(onPressed: stop, iconSize: 60, icon: const Icon(Icons.stop_circle_rounded, color: Colors.blue));

    if (!_timer.isOn && _isFirstLoad) {
      return [ startBt ];
    } else if (!_timer.isOn) {
      return [ startBt, stopBt ];
    }
    return [ pauseBt ];
  }

	Widget sessionIndicator() {
		IntervalInterface i = _timer.interval;
		List s = i.sessions;
		List<Widget> result = s.map((e) {
			List c = e.color;
			double w = 10;
			double h = 10;
			if (s.indexOf(e) == _timer.sessionNumber) {
				w = 15; h = 15;
			}
		  return Container(
				width: w, height: h,
				margin: const EdgeInsets.symmetric(horizontal: 2),
				decoration: BoxDecoration(
					color: Color.fromRGBO(c[0], c[1], c[2], c[3].toDouble()),
					borderRadius: BorderRadius.circular(100),
				)
			);
		}).toList();
		return Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: result,	
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

	// TODO this hard coded
  IntervalInterface interval = IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []); 

  void nextSession() { 
    if ( interval.sessions.length-1 == sessionNumber ) {
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
