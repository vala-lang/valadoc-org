public static int main (string[] args) {
	// Output: ``inf -- 1 -- false``
	float val = float.INFINITY;
	print ("%f -- %s -- %s\n", val, val.is_infinity ().to_string (), val.is_finite ().to_string ());

	// Output: ``nan -- 0 -- false``
	val = float.NAN;
	print ("%f -- %s -- %s\n", val, val.is_infinity ().to_string (), val.is_finite ().to_string ());

	// Output: ``0.300000 -- 0 -- true``
	val = 0.3f;
	print ("%f -- %s -- %s\n", val, val.is_infinity ().to_string (), val.is_finite ().to_string ());

	return 0;
}
