public static int main (string[] args) {
	// Basic types: (true)
	stdout.printf ("bool, %s\n", Variant.is_signature ("b").to_string ());
	stdout.printf ("byte, %s\n", Variant.is_signature ("y").to_string ());
	stdout.printf ("int16, %s\n", Variant.is_signature ("n").to_string ());
	stdout.printf ("uint16%s\n", Variant.is_signature ("q").to_string ());
	stdout.printf ("int32, %s\n", Variant.is_signature ("i").to_string ());
	stdout.printf ("uint32, %s\n", Variant.is_signature ("u").to_string ());
	stdout.printf ("int64, %s\n", Variant.is_signature ("x").to_string ());
	stdout.printf ("uint64, %s\n", Variant.is_signature ("t").to_string ());
	stdout.printf ("variant type handle, %s\n", Variant.is_signature ("h").to_string ());
	stdout.printf ("double, %s\n", Variant.is_signature ("d").to_string ());
	stdout.printf ("string, %s\n", Variant.is_signature ("s").to_string ());
	stdout.printf ("object path, %s\n", Variant.is_signature ("o").to_string ());
	stdout.printf ("variant, %s\n", Variant.is_signature ("g").to_string ());

	// Variants: (true)
	stdout.printf ("variant, %s\n", Variant.is_signature ("v").to_string ());

	// Arrays: (true)
	stdout.printf ("int32[], %s\n", Variant.is_signature ("ai").to_string ());
	stdout.printf ("string[], %s\n", Variant.is_signature ("as").to_string ());
	stdout.printf ("Variant[], %s\n", Variant.is_signature ("av").to_string ());
	stdout.printf ("string[,], %s\n", Variant.is_signature ("a{ss}").to_string ());

	// Invalid: (false)
	stdout.printf ("INVALID, %s\n", Variant.is_signature ("**").to_string ());
	stdout.printf ("INVALID, %s\n", Variant.is_signature ("*{*}").to_string ());

	return 0;
}
