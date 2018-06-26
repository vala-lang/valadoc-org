public static int main (string[] args) {
	double val;
	bool res;

	// Output: ``true => 3.444000``
	res = double.try_parse ("3.444", out val);
	print ("%s => %f\n", res.to_string (), val);

	// Output: ``true => -3.444000``
	res = double.try_parse ("-3.444", out val);
	print ("%s => %f\n", res.to_string (), val);

	// Output: ``false => 3.444000``
	res = double.try_parse ("3.444d", out val);
	print ("%s => %f\n", res.to_string (), val);

	// Output: ``false => 0.000000``
	res = double.try_parse ("d3.444", out val);
	print ("%s => %f\n", res.to_string (), val);

	return 0;
}
