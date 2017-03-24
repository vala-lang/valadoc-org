public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }

public static int main (string[] args) {
	// Output: ``true``
	Type type = typeof (Interface);
	print (" is-derivable: %s\n", type.is_derivable ().to_string ());

	// Output: ``true``
	type = typeof (AbstractGObject);
	print (" is-derivable: %s\n", type.is_derivable ().to_string ());

	// Output: ``true``
	type = typeof (AbstractSimpleObject);
	print (" is-derivable: %s\n", type.is_derivable ().to_string ());

	// Output: ``true``
	type = typeof (Enum);
	print (" is-derivable: %s\n", type.is_derivable ().to_string ());

	return 0;
}
