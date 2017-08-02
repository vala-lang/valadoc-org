public struct MyStruct {
	public int64 a;
	public int64 b;

	public static void* deserialize_func (Json.Node node) {
		assert (node.get_node_type () == Json.NodeType.OBJECT);
		unowned Json.Object obj = node.get_object ();
		assert (obj.get_size () == 2);

		MyStruct* stru = malloc (sizeof (MyStruct));
		stru.a = obj.get_int_member ("a");
		stru.b = obj.get_int_member ("b");
		return stru;
	}

	public string to_string () {
		StringBuilder builder = new StringBuilder ();
		builder.append_printf ("a: %" + int64.FORMAT + "\n", a);
		builder.append_printf ("b: %" + int64.FORMAT, b);
		return builder.str;
	}
}

public static int main (string[] args) {
	// Create a Node:
	Json.Node node;

	try {
		string data = """{ "a" : 3, "b" : 4 }""";
		Json.Parser parser = new Json.Parser ();
		parser.load_from_data (data);
		node = parser.get_root ();
	} catch (Error e) {
		assert_not_reached ();
	}


	// Check whether the struct is deserializeable:
	// Output: ``deserializeable(1): false``
	bool tmp = Json.boxed_can_deserialize (typeof (MyStruct), Json.NodeType.OBJECT);
	print ("deserializeable(1): %s\n", tmp.to_string ());

	// Register our BoxedDeserializeFunc:
	Json.boxed_register_deserialize_func (typeof (MyStruct), Json.NodeType.OBJECT, MyStruct.deserialize_func);

	// Check again:
	// Output: ``deserializeable(2): true``
	tmp = Json.boxed_can_deserialize (typeof (MyStruct), Json.NodeType.OBJECT);
	print ("deserializeable(2): %s\n", tmp.to_string ());


	// Deserialization:
	// Output:
	//  ``a: 3``
	//  ``b: 4``
	MyStruct* stru = (MyStruct*) Json.boxed_deserialize (typeof (MyStruct), node);
	print (stru.to_string ());
	print ("\n");
	delete stru;

	return 0;
}
