public static int main (string[] args) {
	bool t1 = true;
	bool t2 = false;
	bool t3 = (10 > 100 || 100 < 10);

	// Output: ``true, false, false``
	print (@"$t1, $t2, $t3\n");
	return 0;
}
