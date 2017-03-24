public class ObjectA : Object {
	public int property_a { get; set; }
	public int property_b { get; set; }
	public int property_c { get; set; }
	public bool property_d { get; set; }
	public int property_e { get; set; }
}

public class ObjectB : Object {
	public int property_a { get; set; }
	public int property_b { get; set; }
	public int property_c { get; set; }
	public bool property_d { get; set; }
	public int property_e { get; set; }
}

public static int main (string[] args) {
	// Objects:
	ObjectA obja = new ObjectA ();
	ObjectB objb = new ObjectB ();


	//
	// BindingFlags.DEFAULT:
	//

	print ("BindingFlags.DEFAULT:\n");

	obja.property_a = 50;
	objb.property_a = 60;

	obja.bind_property ("property-a", objb, "property-a", BindingFlags.DEFAULT);

	// Output: ``50 - 60``
	print (" %d - %d\n", obja.property_a, objb.property_a);

	// Output: ``10 - 10``
	obja.property_a = 10;
	print (" %d - %d\n", obja.property_a, objb.property_a);

	// Output: ``10 - 15``
	objb.property_a = 15;
	print (" %d - %d\n", obja.property_a, objb.property_a);


	//
	// BindingFlags.BIDIRECTIONAL:
	//

	print ("BindingFlags.BIDIRECTIONAL:\n");

	obja.property_b = 50;
	objb.property_b = 60;

	obja.bind_property ("property-b", objb, "property-b", BindingFlags.BIDIRECTIONAL);

	// Output: ``50 - 60``
	print (" %d - %d\n", obja.property_b, objb.property_b);

	// Output: ``10 - 10``
	obja.property_b = 10;
	print (" %d - %d\n", obja.property_b, objb.property_b);

	// Output: ``15 - 15``
	objb.property_b = 15;
	print (" %d - %d\n", obja.property_b, objb.property_b);


	//
	// BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL:
	//

	print ("BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL:\n");

	obja.property_c = 50;
	objb.property_c = 60;

	obja.bind_property ("property-c", objb, "property-c", BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL);

	// Output: ``50 - 50``
	print (" %d - %d\n", obja.property_c, objb.property_c);

	// Output: ``10 - 10``
	obja.property_c = 10;
	print (" %d - %d\n", obja.property_c, objb.property_c);

	// Output: ``20 - 20``
	objb.property_c = 20;
	print (" %d - %d\n", obja.property_c, objb.property_c);


	//
	// BindingFlags.INVERT_BOOLEAN:
	//

	print ("BindingFlags.INVERT_BOOLEAN:\n");

	obja.property_d = false;
	objb.property_d = true;

	obja.bind_property ("property-d", objb, "property-d", BindingFlags.INVERT_BOOLEAN);

	// Output: ``true - false``
	obja.property_d = true;
	print (" %s - %s\n", obja.property_d.to_string (), objb.property_d.to_string ());

	// Output: ``false - true``
	obja.property_d = false;
	print (" %s - %s\n", obja.property_d.to_string (), objb.property_d.to_string ());


	//
	// Transformer:
	//

	print ("Transformer:\n");

	obja.bind_property ("property-e", objb, "property-e", BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL, (binding, srcval, ref targetval) => {
		int src = (int) srcval;
		targetval.set_int (src * 2);
		return true;
	}, (binding, srcval, ref targetval) => {
		int src = (int) srcval;
		targetval.set_int (src / 2);
		return true;
	});


	obja.property_e = 50;
	objb.property_e = 60;

	// Output: ``30 - 60``
	print (" %d - %d\n", obja.property_e, objb.property_e);

	// Output: ``10 - 20``
	obja.property_e = 10;
	print (" %d - %d\n", obja.property_e, objb.property_e);

	// Output: ``20 - 40``
	objb.property_e = 40;
	print (" %d - %d\n", obja.property_e, objb.property_e);

	return 0;
}
