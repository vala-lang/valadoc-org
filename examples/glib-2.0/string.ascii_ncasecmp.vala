public static int main (string[] args) {
	string str1 = "YOU WILL __OBEY__ THE DALEKS!";
	string str2 = "You will //obey// the daleks!";

	// Compare first 9 characters:
	// Output: ``0``
	int res = str1.ascii_ncasecmp (str2, 9);
	print ("%d\n", res);

	// Compare first 10 characters:
	// Output: ``48``
	res = str1.ascii_ncasecmp (str2, 10);
	print ("%d\n", res);

	return 0;
}
