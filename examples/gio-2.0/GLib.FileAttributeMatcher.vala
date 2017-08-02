public struct Match {
	public string a;
	public string b;

	public Match (string a, string b) {
		this.a = a;
		this.b = b;
	}
}

public static int main (string[] args) {
	Match[] equal_matches = new Match[] {
		Match ("*", "*,*"),
		Match ("*", "*,a::*"),
		Match ("*", "*,a::b"),
		Match ("*", "a::*,*"),
		Match ("*", "a::b,*"),
		Match ("*", "a::b,*,a::*")
	};

	// Output:
	//  ``true, true``
	//  ``true, true``
	//  ``true, true``
	//  ``true, true``
	//  ``true, true``
	//  ``true, true``
	foreach (Match match in equal_matches) {
		FileAttributeMatcher matcher = new FileAttributeMatcher (match.a);
		bool a = matcher.matches (match.a);
		bool b = matcher.matches (match.b);
		print ("%s, %s\n", a.to_string (), b.to_string ());
	}

	return 0;
}
