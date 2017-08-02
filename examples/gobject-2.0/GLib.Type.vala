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
	print ("%s\n", type.name ());
	print (" is-obj: %s\n", type.is_object ().to_string ());
	print (" is-abstr: %s\n", type.is_abstract ().to_string ());
	print (" is-classed: %s\n", type.is_classed ().to_string ());
	print (" is-derivable: %s\n", type.is_derivable ().to_string ());
	print (" is-derived: %s\n", type.is_derived ().to_string ());
	print (" is-fund: %s\n", type.is_fundamental ().to_string ());
	print (" is-inst: %s\n", type.is_instantiatable ().to_string ());
	print (" is-iface: %s\n", type.is_interface ().to_string ());
	print (" is-enum: %s\n", type.is_enum ().to_string ());
	print (" is-flags: %s\n", type.is_object ().to_string ());

	// Output:
	//  `` Children:``
	print (" Children:\n");
	foreach (unowned Type ch in type.children ()) {
		print ("  - %s\n", ch.name ());
	}

	//  `` Interfaces:``
	//  ``  - Interface``
	print (" Interfaces:\n");
	foreach (unowned Type ch in type.interfaces ()) {
		print ("  - %s\n", ch.name ());
	}

	// Output:
	//  `` Parents:``
	//  ``  - GObject``
	print (" Parents:\n");
	for (Type p = type.parent (); p != 0 ; p = p.parent ()) {
		print ("  - %s\n", p.name ());
	}

	return 0;
}
