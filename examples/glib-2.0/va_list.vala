public void print_linesv (string fst_str, va_list list) {
	stdout.puts (fst_str);
	stdout.putc ('\n');

	for (string? str = list.arg<string?> (); str != null ; str = list.arg<string?> ()) {
		stdout.puts (str);
		stdout.putc ('\n');
	}
}

public void print_lines (string fst_str, ...) {
    var list = va_list();
	print_linesv (fst_str, list);
}

public static int main (string[] args) {
	// Output:
	//  ``first line``
	//  ``second line``
	//  ``third line``

	print_lines ("first line", "second line", "third line");
	return 0;
}

