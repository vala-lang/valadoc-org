public static int main (string[] args) {
	string my_wisdom = "  \t Don't worry, I'll soon fix that.  ";
	unowned string res = my_wisdom._chug ();

	// Output:
	//   ``'  	 Don't worry, I'll soon fix that.  '``
	//   ``'Don't worry, I'll soon fix that.  '``
	stdout.printf ("'%s'\n", my_wisdom);
	stdout.printf ("'%s'\n", res);

	return 0;
}
