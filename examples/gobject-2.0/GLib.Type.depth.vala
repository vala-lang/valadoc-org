public abstract class AbstractGObject : Object {}

public static int main (string[] args) {
	// Output: ``2``
	Type type = typeof (AbstractGObject);
	stdout.printf ("  %u\n", type.depth ());
	return 0;
}
