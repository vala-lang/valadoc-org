public int main (string[] args){
	// Output: ``s[ai]mple matched!``
	try {
		string quote = "This is a simple sample.";
		Regex regex = new Regex ("s[ai]mple");

		if (regex.match (quote)){
			print ("%s matched!\n", regex.get_pattern ());
		}
	} catch (RegexError e) {
		print ("Error %s\n", e.message);
	}
	return 0;
}
 
