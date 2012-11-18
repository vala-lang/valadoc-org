public int main (string[] args){
	// Output: ``true``
	bool tmp = Regex.match_simple ("s[ai]mple", "This is a simple sample.");
	stdout.printf ("%s\n", tmp.to_string ());
	return 0;
}
 
