public static int main () {
	// Output:
	//   ``\tOh please, don't call me human.``
	//   ``\tJust \"Doctor\" would do very nicely, thank you.``
	string escaped = "\tOh please, don't call me human.\n\tJust \"Doctor\" would do very nicely, thank you.".escape ("\n");
	stdout.printf ("%s\n", escaped);
	return 0;
}
