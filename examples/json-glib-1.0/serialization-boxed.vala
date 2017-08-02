public struct MyStruct {
	public int64 a;
	public int64 b;

	public static Json.Node serialize_func (void* _boxed) {
		assert (_boxed != null);

		MyStruct* boxed = (MyStruct*) _boxed;

		Json.Node node = new Json.Node (Json.NodeType.OBJECT);
		Json.Object obj = new Json.Object ();
		obj.set_int_member ("a", boxed.a);
		obj.set_int_member ("b", boxed.b);
		node.set_object (obj);
		return node;
	}
}

public static int main (string[] args) {

	// Check whether the struct is serializeable:
	// Output: ``serializeable(1): false``
	bool tmp = Json.boxed_can_serialize (typeof (MyStruct), null);
	print ("serializeable(1): %s\n", tmp.to_string ());

	// Register our BoxedDeserializeFunc:
	Json.boxed_register_serialize_func (typeof (MyStruct), Json.NodeType.OBJECT, MyStruct.serialize_func);

	// Check again:
	// Output: ``serializeable(2): true``
	tmp = Json.boxed_can_serialize (typeof (MyStruct), null);
	print ("serializeable(2): %s\n", tmp.to_string ());


	// Serialize the struct:
	MyStruct stru = {10, 20};
	Json.Node root = Json.boxed_serialize (typeof (MyStruct), &stru);

	// Node to string:
	Json.Generator generator = new Json.Generator ();
	generator.set_root (root);
	string data = generator.to_data (null);

	// Output: ``{"a":10,"b":20}``
	print (data);
	print ("\n");

	return 0;
}
