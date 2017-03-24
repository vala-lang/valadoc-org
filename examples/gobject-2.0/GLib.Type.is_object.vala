public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class AbstractSimpleObject {}
public enum Enum { E }

public static int main (string[] args) {
	// Output: ``false``
	Type type = typeof (Interface);
	print (" is-obj: %s\n", type.is_object ().to_string ());

	// Output: ``true``
	type = typeof (AbstractGObject);
	print (" is-obj: %s\n", type.is_object ().to_string ());

	// Output: ``false``
	type = typeof (AbstractSimpleObject);
	print (" is-obj: %s\n", type.is_object ().to_string ());

	// Output: ``false``
	type = typeof (Enum);
	print (" is-obj: %s\n", type.is_object ().to_string ());

	return 0;
}
