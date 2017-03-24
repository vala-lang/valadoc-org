public static int main (string[] args) {
	string wisdom = "一石二鳥";
	unowned string end = wisdom.offset (wisdom.length);

	// Output: ``鳥二石一``
	while (direct_equal (wisdom, end) == false) {
		end = end.prev_char ();
		unichar c = end.get_char (0);
		print (c.to_string ());
	}
	print ("\n");

	return 0;
}
