public static int main (string[] args) {
	string wisdom = "一石二鳥";
	int index = wisdom.length;
	unichar c;

	// Output: ``鳥二石一``
	while (wisdom.get_prev_char (ref index, out c)) {
		stdout.puts (c.to_string ());
	}
	stdout.putc ('\n');

	return 0;
}
