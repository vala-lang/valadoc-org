public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }

public static int main (string[] args) {
	// Output: ``true``
	Type type = typeof (Interface);
	print (" is-derived: %s\n", type.is_derived ().to_string ());

	// Output: ``true``
	type = typeof (AbstractGObject);
	print (" is-derived: %s\n", type.is_derived ().to_string ());

	// Output: ``false``
	type = typeof (AbstractSimpleObject);
	print (" is-derived: %s\n", type.is_derived ().to_string ());

	// Output: ``true``
	type = typeof (Enum);
	print (" is-derived: %s\n", type.is_derived ().to_string ());

	return 0;
}
