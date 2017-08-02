public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }

public static int main (string[] args) {
	// Output: ``false``
	Type type = typeof (Interface);
	print (" is-abstr: %s\n", type.is_abstract ().to_string ());

	// Output: ``true``
	type = typeof (AbstractGObject);
	print (" is-abstr: %s\n", type.is_abstract ().to_string ());

	// Output: ``true``
	type = typeof (AbstractSimpleObject);
	print (" is-abstr: %s\n", type.is_abstract ().to_string ());

	// Output: ``false``
	type = typeof (Enum);
	print (" is-abstr: %s\n", type.is_abstract ().to_string ());
	return 0;
}
