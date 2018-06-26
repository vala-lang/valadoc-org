public static int main (string[] args) {
	// Local output: ``/usr/bin/ls``
	string? path = Environment.find_program_in_path ("ls");
	print ("%s\n", path);

	// Local output: ``(null)``
	path = Environment.find_program_in_path ("dummy-application-123");
	print ("%s\n", path);

	return 0;
}
