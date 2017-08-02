public static int main (string[] args) {
	
	try {
		string data = """{ "a" : 3, "b" : 4 }""";

		// Deserialization:
		Variant variant = Json.gvariant_deserialize_data (data, -1, null);
		print (variant.print (true));
		print ("\n");
	} catch (Error e) {
		assert_not_reached ();
	}

	return 0;
}
