public static int main (string[] args) {
	string my_wisdom = "  \t I'm here, Brigadier.  ";
	unowned string res = my_wisdom._strip ();

	// Output:
	//   ``'I'm here, Brigadier.'``
	//   ``'I'm here, Brigadier.'``
	print ("'%s'\n", my_wisdom);
	print ("'%s'\n", res);

	return 0;
}
