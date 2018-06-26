public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}
public abstract class MyGObject : AbstractGObject {}

public static int main (string[] args) {
	// Output:
	//  ``AbstractGObject``
	//  ``GObject``
	Type type = typeof (MyGObject);
	for (Type p = type.parent (); p != 0 ; p = p.parent ()) {
		print ("%s\n", p.name ());
	}
	return 0;
}
