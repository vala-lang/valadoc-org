public static int main () {
	string str = "U = R * I";
	unowned string str2 = str.to_string ();
	stdout.printf ("%s\n", str2);
	return 0;
}
