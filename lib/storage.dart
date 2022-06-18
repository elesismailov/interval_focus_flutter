

List getIntervals() {

	// this is a MOCK data
	return [ IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), IntervalInterface('First', [ SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), SessionInterface(10000, [0, 144, 244, 1]), SessionInterface(5000, [0, 244, 56, 1]), ], []), ];
}

getCurrentInterval() {

}

class IntervalInterface {

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

