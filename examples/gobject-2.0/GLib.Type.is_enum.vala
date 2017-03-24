public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }
[Flags]
public enum Flags { E }

public static int main (string[] args) {
	// Output: ``false``
	Type type = typeof (Interface);
	print (" is-enum: %s\n", type.is_enum ().to_string ());

	// Output: ``false``
	type = typeof (AbstractGObject);
	print (" is-enum: %s\n", type.is_enum ().to_string ());

	// Output: ``false``
	type = typeof (AbstractSimpleObject);
	print (" is-enum: %s\n", type.is_enum ().to_string ());

	// Output: ``true``
	type = typeof (Enum);
	print (" is-enum: %s\n", type.is_enum ().to_string ());

	// Output: ``false``
	type = typeof (Flags);
	print (" is-enum: %s\n", type.is_enum ().to_string ());

	return 0;
}
