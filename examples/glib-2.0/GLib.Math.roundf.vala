public static int main (string[] args) {
	// Output:
	//  ``roundf (0.3f) =  0.0f``
	//  ``roundf (0.4f) =  0.0f``
	//  ``roundf (0.5f) =  1.0f``
	//  ``roundf (0.6f) =  1.0f``

	print ("roundf (%.1lff) =  %.1lff\n", 0.3f, Math.roundf (0.3f));
	print ("roundf (%.1lff) =  %.1lff\n", 0.4f, Math.roundf (0.4f));
	print ("roundf (%.1lff) =  %.1lff\n", 0.5f, Math.roundf (0.5f));
	print ("roundf (%.1lff) =  %.1lff\n", 0.6f, Math.roundf (0.6f));

	return 0;
}
