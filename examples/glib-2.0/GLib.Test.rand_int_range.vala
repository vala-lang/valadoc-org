public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/valadoc/driver-0.14.x", () => {
		// --seed R02S855b50e66c1a59011b2cd8f4c28c9996 forces our number generator
		//   to generate the same sequence of numbers for each test/run:
		int32 rand = Test.rand_int_range (int32.MIN, int32.MAX);
		Test.message ("my int: %d", rand);
		assert (rand == -959024836);

		rand = Test.rand_int_range (int32.MIN, int32.MAX);
		Test.message ("my int: %d", rand);
		assert (rand == -48191030);

		rand = Test.rand_int_range (int32.MIN, int32.MAX);
		Test.message ("my int: %d", rand);
		assert (rand == 735395174);
	});

	Test.add_func ("/valadoc/driver-0.16.x", () => {
		assert (Test.rand_int_range (int32.MIN, int32.MAX) == -959024836);
		assert (Test.rand_int_range (int32.MIN, int32.MAX) == -48191030);
		assert (Test.rand_int_range (int32.MIN, int32.MAX) == 735395174);
	});

	Test.run ();
	return 0;
}
