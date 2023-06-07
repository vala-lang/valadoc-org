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
	Data[] mem = { Data('h'), Data('e'), Data('l'),
	               Data('l'), Data('o') };

	stdout.write ((uint8[]) mem);
	print ("\n");
	return 0;
}
