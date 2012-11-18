public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }

public static int main (string[] args) {
	// Output: ``true``
	Type type = typeof (Interface);
	stdout.printf (" is-derivable: %s\n", type.is_derivable ().to_string ());

	// Output: ``true``
	type = typeof (AbstractGObject);
	stdout.printf (" is-derivable: %s\n", type.is_derivable ().to_string ());

	// Output: ``true``
	type = typeof (AbstractSimpleObject);
	stdout.printf (" is-derivable: %s\n", type.is_derivable ().to_string ());

	// Output: ``true``
	type = typeof (Enum);
	stdout.printf (" is-derivable: %s\n", type.is_derivable ().to_string ());

	return 0;
}
