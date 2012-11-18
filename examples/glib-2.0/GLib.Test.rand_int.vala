public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		// --seed R02S855b50e66c1a59011b2cd8f4c28c9996 forces our number generator
		//   to generate the same sequence of numbers for each test/run:
		int32 rand = Test.rand_int ();
		Test.message ("my int: %d", rand);
		assert (rand == 1188458812);

		rand = Test.rand_int ();
		Test.message ("my int: %d", rand);
		assert (rand == 2099292618);

		rand = Test.rand_int ();
		Test.message ("my int: %d", rand);
		assert (rand == -1412088474);
	});

	Test.add_func ("/valadoc/driver-0.16.x", () => {
		assert (Test.rand_int () == 1188458812);
		assert (Test.rand_int () == 2099292618);
		assert (Test.rand_int () == -1412088474);
	});

	Test.run ();
	return 0;
}
