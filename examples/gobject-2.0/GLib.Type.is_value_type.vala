public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }

public static int main (string[] args) {
	// Output: ``true``
	Type type = typeof (Interface);
	stdout.printf (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``true``
	type = typeof (AbstractGObject);
	stdout.printf (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``true``
	type = typeof (AbstractSimpleObject);
	stdout.printf (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``true``
	type = typeof (Enum);
	stdout.printf (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``true``
	type = typeof (string);
	stdout.printf (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``true``
	type = typeof (int8);
	stdout.printf (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``false``
	type = Type.INVALID;
	stdout.printf (" is-value-type: %s\n", type.is_value_type ().to_string ());

	return 0;
}
