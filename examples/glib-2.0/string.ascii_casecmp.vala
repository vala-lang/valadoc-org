public static int main (string[] args) {
	string str1 = "YOU WILL OBEY THE DALEKS!";
	string str2 = "You will obey the daleks!";
	int res = str1.ascii_casecmp (str2);

	// Output: ``0``
	print ("%d\n", res);
	return 0;
}
