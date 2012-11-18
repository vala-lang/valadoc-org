public static int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/libvaladoc/driver-0.12.x", () => {
		Test.timer_start ();
		for (int i = 0; i < 10000 ; i++);
		double elapsed = Test.timer_elapsed ();
		double last_elapsed = Test.timer_last ();
		assert (elapsed == last_elapsed);

		// When smaller values are better:
		Test.minimized_result (elapsed, "for-test: %gsec", elapsed);

		// When larger values are better:
		Test.maximized_result (elapsed, "for-test: %gsec", elapsed);
	});

	Test.run ();
	return 0;
}
