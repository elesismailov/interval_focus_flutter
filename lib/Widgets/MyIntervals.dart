import 'package:flutter/material.dart';


class MyIntervals extends StatefulWidget {

	@override
	State<StatefulWidget> createState() {
		return _MyIntervalsState();
	}

}

class _MyIntervalsState extends State<MyIntervals> {


  @override
  Widget build(BuildContext context) {

		List intervals = getIntervals();
		List<Widget> widgetIntervals = [];

    return Scaffold(
		backgroundColor: Colors.black,
      appBar: AppBar(
				centerTitle: true,
        title: const Text('My Intervals'),
				backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
					children: widgetIntervals,
        ),
      ),
    );
  }
}

class Interval extends StatefulWidget {

	@override
	State<StatefulWidget> createState() => _IntervalState();
}

class _IntervalState extends State<Interval> {

	@override
	Widget build(BuildContext context) {
		return Container(

		);
	}
}
