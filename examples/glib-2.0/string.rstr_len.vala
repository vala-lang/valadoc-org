public static int main (string[] args) {
	string str = "This is hardly rocket science, this is quantum physics!";
	unowned string? pos = str.rstr_len (str.length, "science");
	// Output: ``science, this is quantum physics!``
	print ("%s\n", pos);
	return 0;
}
