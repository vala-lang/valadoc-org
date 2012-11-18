public static int main (string[] args) {
	Test.init (ref args);

	//  Don't do this at home kids!
	double rand1 = 0;
	double rand2 = 0;
	double rand3 = 0;

	Test.add_data_func ("/valadoc/driver-0.14.x", () => {
		// --seed R02S855b50e66c1a59011b2cd8f4c28c9996 forces our number generator
		//   to generate the same sequence of numbers for each test/run:
		rand1 = Test.rand_double ();
		rand2 = Test.rand_double ();
		rand3 = Test.rand_double ();
	});

	Test.add_data_func ("/valadoc/driver-0.16.x", () => {
		assert (Test.rand_double () == rand1);
		assert (Test.rand_double () == rand2);
		assert (Test.rand_double () == rand3);
	});

	Test.run ();
	return 0;
}
