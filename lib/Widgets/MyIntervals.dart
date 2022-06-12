import 'package:flutter/material.dart';

import '../storage.dart';

class MyIntervals extends StatefulWidget {

	@override
	State<StatefulWidget> createState() => _MyIntervalsState();

}

class _MyIntervalsState extends State<MyIntervals> {


  @override
  Widget build(BuildContext context) {

		List intervals = getIntervals();
		List<Widget> widgetIntervals = intervals.map((e) => IntervalWidget(data: e)).toList();

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

class IntervalWidget extends StatefulWidget {

	const IntervalWidget({Key? key, required this.data}) : super(key: key);

	final IntervalInterface data;

	@override
	State<StatefulWidget> createState() => _IntervalWidgetState();
}

class _IntervalWidgetState extends State<IntervalWidget> {

	@override
	Widget build(BuildContext context) {
		IntervalInterface data = widget.data;
		return Container(
			child:  Text(data.title, style: const TextStyle(color: Colors.white)),
		);
	}
}
