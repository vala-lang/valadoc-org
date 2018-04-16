public interface InterfaceA : Object {}
public interface InterfaceB : Object {}
public abstract class AbstractGObject : Object, InterfaceA, InterfaceB {}

public static int main (string[] args) {
	// Output:
	// ``  - InterfaceA``
	// ``  - InterfaceB``
	Type type = typeof (AbstractGObject);
	foreach (unowned Type ch in type.interfaces ()) {
		print ("  - %s\n", ch.name ());
	}

	return 0;
}
