public static int main (string[] args) {
	string my_wisdom = " Gallifrey. I've not heard of it. Perhaps it's in Ireland.  \t ";
	string res = my_wisdom.chomp ();

	// Output:
	//   ``' Gallifrey. I've not heard of it. Perhaps it's in Ireland.  	 '``
	//   ``' Gallifrey. I've not heard of it. Perhaps it's in Ireland.'``

	print ("'%s'\n", my_wisdom);
	print ("'%s'\n", res);

	return 0;
}
