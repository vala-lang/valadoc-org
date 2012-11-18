public static int main (string[] args) {
	string my_wisdom = "  \t I'm here, Brigadier.  ";
	unowned string res = my_wisdom._strip ();

	// Output:
	//   ``'I'm here, Brigadier.'``
	//   ``'I'm here, Brigadier.'``
	stdout.printf ("'%s'\n", my_wisdom);
	stdout.printf ("'%s'\n", res);

	return 0;
}
