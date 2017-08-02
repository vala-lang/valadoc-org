public static int main (string[] args) {
	// Output:
	//  ``llroundf (0.3f) =  0``
	//  ``llroundf (0.4f) =  0``
	//  ``llroundf (0.5f) =  1``
	//  ``llroundf (0.6f) =  1``

	print ("llroundf (%.1lff) =  %" + int64.FORMAT + "\n", 0.3f, Math.llroundf (0.3f));
	print ("llroundf (%.1lff) =  %" + int64.FORMAT + "\n", 0.4f, Math.llroundf (0.4f));
	print ("llroundf (%.1lff) =  %" + int64.FORMAT + "\n", 0.5f, Math.llroundf (0.5f));
	print ("llroundf (%.1lff) =  %" + int64.FORMAT + "\n", 0.6f, Math.llroundf (0.6f));

	return 0;
}
