public static int main (string[] args) {
	
	try {
		// Create a Node:
		// See Json.gvariant_deserialize_data
		string data = """{ "a" : 3, "b" : 4 }""";
		Json.Parser parser = new Json.Parser ();
		parser.load_from_data (data);
		Json.Node node = parser.get_root ();

		// Deserialization:
		Variant variant = Json.gvariant_deserialize (node, null);
		print (variant.print (true));
		print ("\n");
	} catch (Error e) {
		assert_not_reached ();
	}

	return 0;
}
