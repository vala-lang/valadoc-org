public static int main () {
	// Output:
	//   ``	Oh please, don't call me human.``
	//   ``	Just "Doctor" would do very nicely, thank you.``
	string escaped = "\\tOh please, don't call me human.\\n\\tJust \\\"Doctor\\\" would do very nicely, thank you.".compress ();
	stdout.printf ("%s\n", escaped);
	return 0;
}
