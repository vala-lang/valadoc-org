public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }

public static int main (string[] args) {
	// Output: ``false``
	Type type = typeof (Interface);
	stdout.printf (" is-classed: %s\n", type.is_classed ().to_string ());

	// Output: ``true``
	type = typeof (AbstractGObject);
	stdout.printf (" is-classed: %s\n", type.is_classed ().to_string ());

	// Output: ``true``
	type = typeof (AbstractSimpleObject);
	stdout.printf (" is-classed: %s\n", type.is_classed ().to_string ());

	// Output: ``true``
	type = typeof (Enum);
	stdout.printf (" is-classed: %s\n", type.is_classed ().to_string ());

	return 0;
}
