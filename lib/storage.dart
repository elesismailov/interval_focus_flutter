
import 'package:path_provider/path_provider.dart';
import 'dart:io';

List getIntervals() {

	// this is a MOCK data
	return [ IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), ];
}

Future<String> get _localPath async {
	final directory = await getApplicationDocumentsDirectory();
	return directory.path;
}

Future<File> get _userDataFile async {
	final path = await _localPath;
	return File('$path/user_data.json');
}

Future<File> get _userSettingsFile async {
	final path = await _localPath;
	return File('$path/user_settings.json');
}

Future<File> get _localFile async {
	final path = await _localPath;
	return File('$path/counter.txt');
}

IntervalInterface getCurrentInterval() {

	print('hello storage');
	print(_localPath);


	return IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []); 
}

Future<File> writeCounter(str) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString('$str');
}

Future<String> readCounter() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();

		print(contents);

    return contents;
  } catch (e) {
    // If encountering an error, return 0
		print(e);
    return '{}';
  }
}

class IntervalInterface {

	int id = 0;

	String title = '';
	List<SessionInterface> sessions = [];
	List<String> tags = [];

	IntervalInterface(this.title, this.sessions, this.tags);

}

class SessionInterface {
	int len = 0;
	List<num> color = [];

	SessionInterface(this.len, this.color);
}

