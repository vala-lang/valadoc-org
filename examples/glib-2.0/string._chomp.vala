public static int main (string[] args) {
	string my_wisdom = " His scarf killed Stimson. -- Arrest the scarf then.  \t ";
	unowned string res = my_wisdom._chomp ();

	// Output:
	//   ``' His scarf killed Stimson. -- Arrest the scarf then.'``
	//   ``' His scarf killed Stimson. -- Arrest the scarf then.'``
	print ("'%s'\n", my_wisdom);
	print ("'%s'\n", res);

	return 0;
}
