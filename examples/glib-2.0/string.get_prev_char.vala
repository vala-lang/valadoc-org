public static int main (string[] args) {
	string wisdom = "一石二鳥";
	int index = wisdom.length;
	unichar c;

	// Output: ``鳥二石一``
	while (wisdom.get_prev_char (ref index, out c)) {
		print (c.to_string ());
	}
	print ("\n");

	return 0;
}
