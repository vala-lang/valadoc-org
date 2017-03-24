public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }

public static int main (string[] args) {
	// Output: ``true``
	Type type = typeof (Interface);
	print (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``true``
	type = typeof (AbstractGObject);
	print (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``true``
	type = typeof (AbstractSimpleObject);
	print (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``true``
	type = typeof (Enum);
	print (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``true``
	type = typeof (string);
	print (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``true``
	type = typeof (int8);
	print (" is-value-type: %s\n", type.is_value_type ().to_string ());

	// Output: ``false``
	type = Type.INVALID;
	print (" is-value-type: %s\n", type.is_value_type ().to_string ());

	return 0;
}
