public static int main (string[] args) {
	int64 val;
	bool res;

	// Output: ``true => 34``
	res = int64.try_parse ("34", out val);
	print ("%s => %" + int64.FORMAT + "\n", res.to_string (), val);

	// Output: ``true => -34``
	res = int64.try_parse ("-34", out val);
	print ("%s => %" + int64.FORMAT + "\n", res.to_string (), val);

	// Output: ``false => 0``
	res = int64.try_parse ("d34", out val);
	print ("%s => %" + int64.FORMAT + "\n", res.to_string (), val);

	// Output: ``false => 34``
	res = int64.try_parse ("34d", out val);
	print ("%s => %" + int64.FORMAT + "\n", res.to_string (), val);
	return 0;
}
