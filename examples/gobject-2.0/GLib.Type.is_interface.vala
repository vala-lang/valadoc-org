public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }

public static int main (string[] args) {
	// Output: ``true``
	Type type = typeof (Interface);
	print (" is-interface: %s\n", type.is_interface ().to_string ());

	// Output: ``false``
	type = typeof (AbstractGObject);
	print (" is-interface: %s\n", type.is_interface ().to_string ());

	// Output: ``false``
	type = typeof (AbstractSimpleObject);
	print (" is-interface: %s\n", type.is_interface ().to_string ());

	// Output: ``false``
	type = typeof (Enum);
	print (" is-interface: %s\n", type.is_interface ().to_string ());

	return 0;
}
