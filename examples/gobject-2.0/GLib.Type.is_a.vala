public interface Interface : Object {}

public static int main (string[] args) {
	// Output: ``true``
	bool tmp = typeof (Interface).is_a (typeof (Object));
	print ("%s\n", tmp.to_string ());

	// Output: ``false``
	tmp = typeof (Object).is_a (typeof (Interface));
	print ("%s\n", tmp.to_string ());
	return 0;
}
