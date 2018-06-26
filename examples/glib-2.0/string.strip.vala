public static int main (string[] args) {
	string my_wisdom = "  \t You're standing on my scarf.  ";
	string res = my_wisdom.strip ();

	// Output:
	//   ``'  	 You're standing on my scarf.  '``
	//   ``'You're standing on my scarf.'``
	print ("'%s'\n", my_wisdom);
	print ("'%s'\n", res);

	return 0;
}
