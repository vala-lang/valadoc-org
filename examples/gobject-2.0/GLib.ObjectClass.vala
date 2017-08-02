public class MyObject : Object {
	public int myprop1 { get; set; }
	public int myprop2 { get; set; }
	public int myprop3 { get; set; }
}

public static int main (string[] args) {
	// Output:
	//  ``myprop1``
	//  ``myprop2``
	//  ``myprop3``
	Type type = typeof (MyObject);
	ObjectClass ocl = (ObjectClass) type.class_ref ();
	foreach (ParamSpec spec in ocl.list_properties ()) {
		print ("%s\n", spec.get_name ());
	}

	// Output: ``nick: myprop1``
	unowned ParamSpec? spec = ocl.find_property ("myprop1"); 
	print ("nick: %s\n", spec.get_nick ());

	return 0;
}
