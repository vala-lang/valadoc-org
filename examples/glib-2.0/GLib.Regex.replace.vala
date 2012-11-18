public int main (string[] args){
	try {
		string quote = "This is a simple sample.";
		Regex regex = new Regex ("s[ai]mple");

		// Output: ``Result: This is a XXX XXX.``
		string result = regex.replace (quote, quote.length, 0, "XXX");
		stdout.printf ("Result: %s\n", result);
	} catch (RegexError e) {
		stdout.printf ("Error: %s\n", e.message);
	}
	return 0;
}
 
