import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './notifications.dart';

import './Timer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await notificationsApi.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.black,
      // ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
				backgroundColor: Colors.black,
				elevation: 0,
				actions: [
					ElevatedButton(onPressed: () {
						print(1);
						Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => const Route1())
							);
					}, child: Text('Stats')),
					ElevatedButton(onPressed: () {
						print(1);
						Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => const Route1())
							);
					}, child: Text('Settings')),
				],
      ),
      body: TimerWidget(),
    );
  }
}

class Route1 extends StatelessWidget {
  const Route1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
		backgroundColor: Colors.black,
      appBar: AppBar(
				centerTitle: true,
        title: const Text('Settings'),
				backgroundColor: Colors.black,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
						Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
