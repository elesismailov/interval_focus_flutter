

List getIntervals() {

	// this is a MOCK data
	return [
		IntervalInterface('First', [10000, 5000, 10000, 5000], []),
		IntervalInterface('First', [10000, 5000, 10000, 5000], []),
		IntervalInterface('First', [10000, 5000, 10000, 5000], []),
		IntervalInterface('First', [10000, 5000, 10000, 5000], []),
		IntervalInterface('First', [10000, 5000, 10000, 5000], []),
	];

}

class IntervalInterface {

	String title = '';
	List<int> interval = [];
	List<String> tags = [];

	IntervalInterface(this.title, this.interval, this.tags);

}

class SessionInterface {

}

