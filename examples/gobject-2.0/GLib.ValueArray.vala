private inline Value create_string_value (string str) {
	Value val = Value (typeof (string));
	val.set_string (str);
	return val;
}

public static int main (string[] args) {
	ValueArray array = new ValueArray (10);

	array.append (create_string_value ("BB"));
	array.append (create_string_value ("DD"));
	array.prepend (create_string_value ("AA"));

	// Output: ``Len: 3``
	print ("Len: %u\n", array.n_values);

	array.insert (2, create_string_value ("CC"));
	array.remove (3);
	

	// Output:
	//  ``AA``
	//  ``BB``
	//  ``CC``
	foreach (Value val in array.values) {
		print ("%s\n", val.get_string ());
	}

	return 0;
}
