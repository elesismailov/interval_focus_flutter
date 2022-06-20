
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

List getIntervals() {

	// this is a MOCK data
	return [ IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1])], [], 0), IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], [], 1) ];
}

Future<String> get _localPath async {
	final directory = await getApplicationDocumentsDirectory();
	return directory.path;
}

Future<File> get _dataFile async {
	final path = await _localPath;
	return File('$path/user_data.json');
}

Future<File> get _settingsFile async {
	final path = await _localPath;
	return File('$path/user_settings.json');
}

Future<File> get _localFile async {
	final path = await _localPath;
	return File('$path/counter.txt');
}

int currentIntervalId = 0;
List intervals = [
	IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], [], 0),
	IntervalInterface('First', [ SessionInterface(2400000, [0, 144, 24, 1]), SessionInterface(1200000, [0, 244, 56, 1]), SessionInterface(2400000, [0, 144, 244, 1]), SessionInterface(120000, [0, 24, 56, 1]), ], [], 1)
		];

void setCurrentInterval(id) {
	print('this sets the current interval with $id');
	currentIntervalId = id;
}

IntervalInterface getCurrentInterval() {
	print('get called');
	return intervals[currentIntervalId]; 
}

Future<Map> readSettings() async {
	try {
		final file = await _settingsFile;
		final jsonString = await file.readAsString();
		Map<String, dynamic> settingsMap = jsonDecode(jsonString);
		return settingsMap;
	} catch (e) {
		// create file
		final file = await _settingsFile;
		// TODO create settings file initializer
		file.writeAsString('{}');
		Map<String, dynamic> settingsMap = jsonDecode('{}');
		return settingsMap;
	}
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

	IntervalInterface(this.title, this.sessions, this.tags, this.id);

}

class SessionInterface {
	int len = 0;
	List<num> color = [];

	SessionInterface(this.len, this.color);
}

