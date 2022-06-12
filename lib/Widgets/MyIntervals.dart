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
		List<Widget> sessions = data.interval.map((e) => sessionWidget(e)).toList();
		return Container(
			width: double.infinity,
			constraints: const BoxConstraints(maxWidth: 385),
			padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
			decoration: BoxDecoration(
				 borderRadius: BorderRadius.circular(15),
				 color: const Color.fromRGBO(51, 51, 51, 100),

			),
			margin: const EdgeInsets.only(top: 20),
			//child:  Text(data.title, style: const TextStyle(color: Colors.white)),
			child: Column(
				children: [
					Container(
						width: double.infinity,
						margin: const EdgeInsets.only(bottom: 15),
						child: Text(data.title, style: const TextStyle(color: Colors.white)),
					),
					
					Row(
						children: sessions,
					),
				],
			),
		);
	}

	Widget sessionWidget(len) {
		return Container(
			child: Text('$len'),
			);
	}
}
