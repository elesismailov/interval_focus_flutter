

List getIntervals() {

	// this is a MOCK data
	return [
		IntervalInterface('First', [10000, 5000, 10000, 5000], [10, 20, 30, 100], []),
		IntervalInterface('First', [10000, 5000, 10000, 5000], [10, 20, 30, 100], []),
		IntervalInterface('First', [10000, 5000, 10000, 5000], [10, 20, 30, 100], []),
		IntervalInterface('First', [10000, 5000, 10000, 5000], [10, 20, 30, 100], []),
		IntervalInterface('First', [10000, 5000, 10000, 5000], [10, 20, 30, 100], []),
	];

}

class IntervalInterface {

	String title = '';
	List<int> interval = [];
	List<int> color = []; // [ r, g, b, o]
	List<String> tags = [];

	IntervalInterface(this.title, this.interval, this.color, this.tags);

}
