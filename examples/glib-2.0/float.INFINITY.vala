public static int main (string[] args) {
	// Output: ``inf -- 1 -- false``
	float val = float.INFINITY;
	print ("%f -- %s -- %s\n", val, val.is_infinity ().to_string (), val.is_finite ().to_string ());
	return 0;
}
