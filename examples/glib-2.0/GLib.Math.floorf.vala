public static int main (string[] args) {
	// Output:
	//  ``floorf (3.1f) = 3.0f``
	//  ``floorf (3.9f) = 3.0f``
	print ("floorf (%.1lff) = %.1lff\n", 3.1f, Math.floorf (3.1f));
	print ("floorf (%.1lff) = %.1lff\n", 3.9f, Math.floorf (3.9f));
	return 0;
}
