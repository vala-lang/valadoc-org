public static int main (string[] args) {
	string my_wisdom = "  \t I'll kill him with this deadly jelly baby!  ";
	string res = my_wisdom.chug ();

	// Output:
	//   ``'  	 I'll kill him with this deadly jelly baby!  '``
	//   ``'I'll kill him with this deadly jelly baby!  '``
	print ("'%s'\n", my_wisdom);
	print ("'%s'\n", res);

	return 0;
}
