public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }

public static int main (string[] args) {
	// Output: ``false``
	Type type = typeof (Interface);
	print (" is-deep-derivable: %s\n", type.is_deep_derivable ().to_string ());

	// Output: ``true``
	type = typeof (AbstractGObject);
	print (" is-deep-derivable: %s\n", type.is_deep_derivable ().to_string ());

	// Output: ``true``
	type = typeof (AbstractSimpleObject);
	print (" is-deep-derivable: %s\n", type.is_deep_derivable ().to_string ());

	// Output: ``false``
	type = typeof (Enum);
	print (" is-deep-derivable: %s\n", type.is_deep_derivable ().to_string ());

	return 0;
}
