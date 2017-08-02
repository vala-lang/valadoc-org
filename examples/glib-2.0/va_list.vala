public void print_linesv (string fst_str, va_list list) {
	print (fst_str);
	print ("\n");

	for (string? str = list.arg<string?> (); str != null ; str = list.arg<string?> ()) {
		print (str);
		print ("\n");
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
