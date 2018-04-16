public static int main (string[] args) {
	// Basic types: (true)
	print ("bool, %s\n", Variant.is_signature ("b").to_string ());
	print ("byte, %s\n", Variant.is_signature ("y").to_string ());
	print ("int16, %s\n", Variant.is_signature ("n").to_string ());
	print ("uint16%s\n", Variant.is_signature ("q").to_string ());
	print ("int32, %s\n", Variant.is_signature ("i").to_string ());
	print ("uint32, %s\n", Variant.is_signature ("u").to_string ());
	print ("int64, %s\n", Variant.is_signature ("x").to_string ());
	print ("uint64, %s\n", Variant.is_signature ("t").to_string ());
	print ("variant type handle, %s\n", Variant.is_signature ("h").to_string ());
	print ("double, %s\n", Variant.is_signature ("d").to_string ());
	print ("string, %s\n", Variant.is_signature ("s").to_string ());
	print ("object path, %s\n", Variant.is_signature ("o").to_string ());
	print ("variant, %s\n", Variant.is_signature ("g").to_string ());

	// Variants: (true)
	print ("variant, %s\n", Variant.is_signature ("v").to_string ());

	// Arrays: (true)
	print ("int32[], %s\n", Variant.is_signature ("ai").to_string ());
	print ("string[], %s\n", Variant.is_signature ("as").to_string ());
	print ("Variant[], %s\n", Variant.is_signature ("av").to_string ());
	print ("string[,], %s\n", Variant.is_signature ("a{ss}").to_string ());

	// Invalid: (false)
	print ("INVALID, %s\n", Variant.is_signature ("**").to_string ());
	print ("INVALID, %s\n", Variant.is_signature ("*{*}").to_string ());

	return 0;
}
