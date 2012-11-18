public interface Interface : Object {}
public abstract class AbstractGObject : Object, Interface {}

public static int main (string[] args) {
	// Output:
	//  ``AbstractGObject``
	//  `` is-obj: true``
	//  `` is-abstr: true``
	//  `` is-classed: true``
	//  `` is-derivable: true``
	//  `` is-derived: true``
	//  `` is-fund: false``
	//  `` is-inst: true``
	//  `` is-iface: false``
	//  `` is-enum: false``
	//  `` is-flags: true``
	Type type = typeof (AbstractGObject);
	stdout.printf ("%s\n", type.name ());
	stdout.printf (" is-obj: %s\n", type.is_object ().to_string ());
	stdout.printf (" is-abstr: %s\n", type.is_abstract ().to_string ());
	stdout.printf (" is-classed: %s\n", type.is_classed ().to_string ());
	stdout.printf (" is-derivable: %s\n", type.is_derivable ().to_string ());
	stdout.printf (" is-derived: %s\n", type.is_derived ().to_string ());
	stdout.printf (" is-fund: %s\n", type.is_fundamental ().to_string ());
	stdout.printf (" is-inst: %s\n", type.is_instantiatable ().to_string ());
	stdout.printf (" is-iface: %s\n", type.is_interface ().to_string ());
	stdout.printf (" is-enum: %s\n", type.is_enum ().to_string ());
	stdout.printf (" is-flags: %s\n", type.is_object ().to_string ());

	// Output:
	//  `` Children:``
	stdout.printf (" Children:\n");
	foreach (unowned Type ch in type.children ()) {
		stdout.printf ("  - %s\n", ch.name ());
	}

	//  `` Interfaces:``
	//  ``  - Interface``
	stdout.printf (" Interfaces:\n");
	foreach (unowned Type ch in type.interfaces ()) {
		stdout.printf ("  - %s\n", ch.name ());
	}

	// Output:
	//  `` Parents:``
	//  ``  - GObject``
	stdout.printf (" Parents:\n");
	for (Type p = type.parent (); p != 0 ; p = p.parent ()) {
		stdout.printf ("  - %s\n", p.name ());
	}

	return 0;
}
