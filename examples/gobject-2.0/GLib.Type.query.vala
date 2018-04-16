public abstract class AbstractGObject : Object {
}

public static int main (string[] args) {
	Type type = typeof (AbstractGObject);
	TypeQuery query;

	// Output:
	//  ``type: 156018024``
	//  ``name: AbstractGObject``
	//  ``class-size: 68``
	//  ``instance-size: 16``
	type.query (out query);
	print ("type: %s\n", query.type.to_string ());
	print ("name: %s\n", query.type_name);
	print ("class-size: %u\n", query.class_size);
	print ("instance-size: %u\n", query.instance_size);

	return 0;
}
