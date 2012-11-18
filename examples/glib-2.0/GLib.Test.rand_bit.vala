public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		// --seed R02S855b50e66c1a59011b2cd8f4c28c9996 forces our number generator
		//   to generate the same sequence of numbers for each test/run:
		bool rand = Test.rand_bit ();
		Test.message ("my bit: %s", rand.to_string ());
		assert (rand == false);

		rand = Test.rand_bit ();
		Test.message ("my bit: %s", rand.to_string ());
		assert (rand == true);

		rand = Test.rand_bit ();
		Test.message ("my bit: %s", rand.to_string ());
		assert (rand == false);
	});

	Test.add_func ("/valadoc/driver-0.16.x", () => {
		assert (Test.rand_bit () == false);
		assert (Test.rand_bit () == true);
		assert (Test.rand_bit () == false);
	});

	Test.run ();
	return 0;
}
