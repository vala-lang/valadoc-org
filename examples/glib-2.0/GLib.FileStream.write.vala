public struct Data {
	public char l;
	public char h;

	public Data (char x) {
		l = x.tolower ();
		h = x.toupper ();
	}
}

public static int main (string[] args) {
	// array of 5 elements with size 2 bytes (2 * char)
	Data [] mem = { Data('h'), Data('e'), Data('l'),
					Data('l'), Data('o') };

	// write array of 5 elements with 2 bytes size
	stdout.write ((uint8[]) mem, sizeof (Data));
	print ("\n");
	return 0;
}
