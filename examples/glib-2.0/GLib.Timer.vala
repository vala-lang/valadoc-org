public static int main (string[] args) {
	ulong microseconds;
	double seconds;

	// create a timer object:
	Timer timer = new Timer ();

	// 1. measurement, part 1:
	for (int i = 0; i < 10000; i++);
	timer.stop ();

 	seconds = timer.elapsed (out microseconds);
	print ("1.1: %s, %lu\n", seconds.to_string (), microseconds);

	// 1. measurement, part 2:
	timer.@continue ();
	for (int i = 0; i < 100000; i++);
	timer.stop ();

 	seconds = timer.elapsed (out microseconds);
	print ("1.2: %s, %lu\n", seconds.to_string (), microseconds);


	// 2. measurement:
	timer.reset ();
	for (int i = 0; i < 10000; i++);
	for (int i = 0; i < 100000; i++);
	timer.stop ();

 	seconds = timer.elapsed (out microseconds);
	print ("2.1: %s, %lu\n", seconds.to_string (), microseconds);
	return 0;
}
