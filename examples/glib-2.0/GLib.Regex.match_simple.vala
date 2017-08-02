public int main (string[] args){
	// Output: ``true``
	bool tmp = Regex.match_simple ("s[ai]mple", "This is a simple sample.");
	print ("%s\n", tmp.to_string ());
	return 0;
}
 
