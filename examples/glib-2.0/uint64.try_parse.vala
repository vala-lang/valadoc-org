public static int main (string[] args) {
	uint64 val;
	bool res;

	// Output: ``true => 34``
	res = uint64.try_parse ("34", out val);
	print ("%s => %" + uint64.FORMAT + "\n", res.to_string (), val);

	// Output: ``false => 0``
	res = uint64.try_parse ("d34", out val);
	print ("%s => %" + uint64.FORMAT + "\n", res.to_string (), val);

	// Output: ``false => 34``
	res = uint64.try_parse ("34d", out val);
	print ("%s => %" + uint64.FORMAT + "\n", res.to_string (), val);
	return 0;
}
