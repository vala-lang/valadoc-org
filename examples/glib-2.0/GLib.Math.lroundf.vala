public static int main (string[] args) {
	// Output:
	//  ``lroundf (0.3f) =  0f``
	//  ``lroundf (0.4f) =  0f``
	//  ``lroundf (0.5f) =  1f``
	//  ``lroundf (0.6f) =  1f``

	stdout.printf ("lroundf (%.1lff) =  %lif\n", 0.3f, Math.lroundf (0.3f));
	stdout.printf ("lroundf (%.1lff) =  %lif\n", 0.4f, Math.lroundf (0.4f));
	stdout.printf ("lroundf (%.1lff) =  %lif\n", 0.5f, Math.lroundf (0.5f));
	stdout.printf ("lroundf (%.1lff) =  %lif\n", 0.6f, Math.lroundf (0.6f));

	return 0;
}
