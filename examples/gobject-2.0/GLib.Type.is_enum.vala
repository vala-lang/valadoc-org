public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }
[Flags]
public enum Flags { E }

public static int main (string[] args) {
	// Output: ``false``
	Type type = typeof (Interface);
	stdout.printf (" is-enum: %s\n", type.is_enum ().to_string ());

	// Output: ``false``
	type = typeof (AbstractGObject);
	stdout.printf (" is-enum: %s\n", type.is_enum ().to_string ());

	// Output: ``false``
	type = typeof (AbstractSimpleObject);
	stdout.printf (" is-enum: %s\n", type.is_enum ().to_string ());

	// Output: ``true``
	type = typeof (Enum);
	stdout.printf (" is-enum: %s\n", type.is_enum ().to_string ());

	// Output: ``false``
	type = typeof (Flags);
	stdout.printf (" is-enum: %s\n", type.is_enum ().to_string ());

	return 0;
}
