import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TimerHomePage(),
    ));
}

class TimerHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
	String _aString = 'hello h string';

    return Scaffold(
		backgroundColor: Colors.grey,
        body: Center(
            child: Column(
			mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Text('Focus'),
					Text('00:00'),
					Text('Session Number'),
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							ElevatedButton( onPressed: () {}, child: Text('Start')),
							ElevatedButton( onPressed: () {}, child: Text('Pause')),
					]),
			],),
          ),
      );
  }

}
