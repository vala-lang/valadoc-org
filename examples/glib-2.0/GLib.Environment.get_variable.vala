public static int main () {
	// Local Output: ``fatal_criticals``
	unowned string arg = Environment.get_variable ("G_DEBUG");
	print ("%s\n", arg);
	return 0;
}
