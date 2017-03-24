public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }
[Flags]
public enum Flags { E }

public static int main (string[] args) {
	// Output: ``false``
	Type type = typeof (Interface);
	print (" is-flags: %s\n", type.is_flags ().to_string ());

	// Output: ``false``
	type = typeof (AbstractGObject);
	print (" is-flags: %s\n", type.is_flags ().to_string ());

	// Output: ``false``
	type = typeof (AbstractSimpleObject);
	print (" is-flags: %s\n", type.is_flags ().to_string ());

	// Output: ``false``
	type = typeof (Enum);
	print (" is-flags: %s\n", type.is_flags ().to_string ());

	// Output: ``true``
	type = typeof (Flags);
	print (" is-flags: %s\n", type.is_flags ().to_string ());

	return 0;
}
